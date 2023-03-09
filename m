Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB26B26A6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjCIOUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjCIOUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:20:15 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30188BF399;
        Thu,  9 Mar 2023 06:20:10 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id g3so2033708wri.6;
        Thu, 09 Mar 2023 06:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678371608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9PFCuPFcq1FIHz8HOZSI5nxjlQ6hpHQldXpRzabQWk=;
        b=pQ8rH9hmAvMGPdlWLtsaiCL1tbAk6J5Bet/1wrFc3yD0T50sPxhzJap0s2h/tEDON1
         ZyckrHIm+7bwS9K33CaoBmOEZv2I7afmQGc2Er54g/6BTDs+CyEWTFawrPc5lAPk872n
         dmirs2Ttda4PnqKgROjUd7CIwz9tdnPCkSyzGIlnzIK6bEyGRSqA1H7/Ze090yaenbxK
         iPzeJNvkLQF6jNvmwsa7eHyXANDHZkBWQs6sisMepYXK+3QyecdSDDX0uIOJQsDjVcfx
         gAyo8YDxkCaJ9wJqVQYaGvOmMuszKOMwbyHS/bu+S6gVRzJL6eI6sGaSbulGjMzjlnVQ
         sYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678371608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9PFCuPFcq1FIHz8HOZSI5nxjlQ6hpHQldXpRzabQWk=;
        b=xFMfRC9HlTvcN8cA8S5lBKg9TAPjgd8DgspIL6eI4iwtEXmoKcAOvYtdS1Om4+4MHN
         QErD9O49XcbcSOitRv2tIFbxBvGU10xaq3+NNqAC84qPyXKXW9Q/6zTZZWPmY7h7Cb3l
         IS2zf0wHDm/YSW3e1yeXHVd69vzqpepCIW2BEt/Aet1xDZbZZnp0bElxNyRl2hGCIfeo
         IzngZd+z7cgyGQ+30aqbwueEHKTyBQQaZUwpBVQCOKvi/5vghPk7310HvuhalpQJ/KvJ
         gEMkF4X493ToOmKZKvn4O43D5otS8YPwhs+tHZAnyan059QHa3JIZ8BVsNHT+ZFXZkgM
         /bqQ==
X-Gm-Message-State: AO0yUKX4H5YaTQXMG6UimAe8iQKyLDEn/Njf2qc4D4wBnpGK/VEfK+EW
        Z4pLAbNdTekirveibikhiQl98QxHWterhlcvUyk=
X-Google-Smtp-Source: AK7set+Yd9KrImooA6uxrXUVmDh+Rcs9q/1b8CgKBFtf9L4gNgxW+NQjjkIdwpsMyntXGCBQF88sBj/dwaEvM3BdnWg=
X-Received: by 2002:adf:dd4f:0:b0:2c5:5297:1f9a with SMTP id
 u15-20020adfdd4f000000b002c552971f9amr4901402wrm.14.1678371608475; Thu, 09
 Mar 2023 06:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20220911174551.653599-1-sergiu.moga@microchip.com>
 <20220925220304.buk3yuqoh6vszfci@mobilestation> <18e6e8a8-6412-7e31-21e0-6becd4400ac1@microchip.com>
 <20220926172454.kbpzck7med5bopre@mobilestation> <1766f6ef-d9d8-04f7-a6bf-0ea6bc0b3d23@linaro.org>
 <f647e713a65f5d3f0f2e3af95c4d0a89@walle.cc> <1849e2c8-54f5-9e56-4ed8-8b0e4a826d04@linaro.org>
 <302ecf0421fe4c99fca3eb0ca2f66127@walle.cc> <5183a184-c72d-3acd-70cd-6aa1e31533f5@linaro.org>
 <03a9f117316ab81f1b5a18100f771e65@walle.cc> <6c2090bf-d102-a333-3a83-03abe81ff70e@linaro.org>
 <460ef5ff3846b409b322ca53559e2476@walle.cc> <b8b61fc0-1e4f-146b-2036-03fda5359585@linaro.org>
 <bf57f3aafc3e0a02c81dab905ce9497e@walle.cc>
In-Reply-To: <bf57f3aafc3e0a02c81dab905ce9497e@walle.cc>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 9 Mar 2023 22:19:55 +0800
Message-ID: <CAJsYDVJ_UtGqOm_HsN4X4nAuy9svXe4XV6aeG_fg8cWDrgrHMQ@mail.gmail.com>
Subject: Re: [PATCH] spi: Replace `dummy.nbytes` with `dummy.ncycles`
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Sergiu.Moga@microchip.com, Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com, chin-ting_kuo@aspeedtech.com,
        clg@kaod.org, joel@jms.id.au, andrew@aj.id.au,
        kdasu.kdev@gmail.com, han.xu@nxp.com, john.garry@huawei.com,
        matthias.bgg@gmail.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, haibo.chen@nxp.com,
        yogeshgaur.83@gmail.com, heiko@sntech.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        michal.simek@xilinx.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Mar 9, 2023 at 10:04=E2=80=AFPM Michael Walle <michael@walle.cc> wr=
ote:
>
> Am 2023-03-09 14:54, schrieb Tudor Ambarus:
> > On 09.03.2023 15:33, Michael Walle wrote:
> >>>>> The controllers that can talk in dummy ncycles don't need the
> >>>>> dummy.{buswidth, dtr} fields.
> >>>>>
> >>>>> The controllers that can't talk in dummy cycles, but only on a
> >>>>> "byte"
> >>>>> boundary need both buswidth and dtr fields. Assume a flash needs 32
> >>>>> dummy cycles for an op on 8D-8D-8D mode. If the controller does not
> >>>>> have
> >>>>> the buswidth and dtr info, it can't convert the dummy ncycles to
> >>>>> nbytes.
> >>>>> If he knows only that buswidth is 8, it will convert ncycles to 4
> >>>>> bytes.
> >>>>> If dtr is also specified it converts ncycles to 2 bytes.
> >>>>
> >>>> No they don't need it. Lets take your semper flash and assume it
> >>>> needs
> >>>> 12 latency cycles. SPI-NOR will set ncycles to 12 *regardless of the
> >>>> mode
> >>>> or dtr setting*. The controller then knows we need 12 clock cycles.
> >>>> It has
> >>>> then to figure out how that can be achieved. E.g. if it can only do
> >>>> the
> >>>> "old" byte programming and is in quad mode, good for it. It will
> >>>> send 6
> >>>> dummy bytes, which will result in 12 dummy clock cycles, because 1
> >>>> byte
> >>>> takes two clock cycles in quad SDR mode. If its in octal mode, send
> >>>> 12
> >>>> bytes. If its in dual mode, send 3 bytes. Obiously, it cannot be in
> >>>> single bit mode, because it cannot send 1.5 bytes..
> >>>>
> >>>
> >>> You miss the fact that you can have 1-1-4. What buswidth do you use
> >>> for dummy, the address buswidth or the data buswidth?
> >>
> >> Doesn't matter, does it? The driver is free to chose, 1, 4, or
> >> anything
> >> else. You don't sample any data during the dummy phase.
> >> To answer your question: single for instruction, single for address,
> >> whatever you choose for dummy as long as there are ncycles space
> >> between
> >> address and data, and quad for data.
> >
> > Huh? How does the controller chose, based on what?
>
> Based on its own capabilities. It can choose either way. In the end
> what matters is how many clock cycles there are between the address
> and data phase. And you only need to convey that information to the
> SPI controller - your new ncycles.

It does matter. Controller may be designed to actively drive
MOSI/WP/HOLD during single-spi dummy cycles and WP/HOLD
during dual-spi dummy cycles. If the pin modes between the
controller and device mismatched, worst case scenario
the chip may get fried.

--=20
Regards,
Chuanhong Guo
