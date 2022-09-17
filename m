Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09B15BBA0B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 20:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiIQS6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 14:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIQS5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 14:57:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4435024BDE;
        Sat, 17 Sep 2022 11:57:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c11so40968419wrp.11;
        Sat, 17 Sep 2022 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date;
        bh=SPZMqobD9fw5tzmDxboNL8OzW6a3xWpEgbxCQr5TdTM=;
        b=W29ohG9AtGj1WSrLLTmSoXL9aZ62Q2oe91kjb7hDhC5vzx+FmVqpoII5Ktsw9ielRI
         /aKBcli5yFTD9qHo3Y6YDrcsry6yPhf7mQQThpbcYWQlDwP88P+Gr00gszEzJCDUFbHP
         ecHtxywZxDQyfPVk8Mf5JxlkgY5DO2jQYVozlkaJjhhghaCl2pQFgo/0bsEWmd/cho7H
         zO2LM01kRR7RD76+NEpWRrvaGIr0vVBD4uywXubaPswqbEFL1v952C7M2O9lyjxScm1r
         0cnh4LlFKSCl3SZP6qvkn4pwJho/5/T/+6Vm1LFk+b6xIQNow2gWviGPYWV1trHdk2Jw
         g94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=SPZMqobD9fw5tzmDxboNL8OzW6a3xWpEgbxCQr5TdTM=;
        b=jjqp6AGjzE80xb32rhM5WaBpQ+uCZPCcX9wLAnHqPArHmoECh6WJ9NfWmDg9vOQkDh
         VqTUIXeQtQXAq23GL4LR2S1Xm3nb1EQFvdwSj9cgU2J7PZsDnGrPJN1F/tEeWh391yq3
         s84kZZDiwlgxoY4j463TzxcEfwsJLnXwFqcGYgoERggO6IxUL1RrDVwJ/tswBmm076Ak
         Emj5KCKR1faTct10xWsu6+MFZl5x+kyP21H7BFfOQO0RLNmg96enSxJCrQ+mCFau94QY
         d2QaMCJPF/necV58mZkMQdegTcDtd9MLNCOF+KLouy+ArcD+0A7SA/SDUvtLUYqCu3Nz
         qLEA==
X-Gm-Message-State: ACrzQf2T1k+JVjymPxIkDe8nuHKJ6UcBhkpYsgKCo/SVoIU6WWMIXjYw
        MEEk+gMOQPN0IxUQfmFMu+w=
X-Google-Smtp-Source: AMsMyM58V8FLw3xUrZFuIyrtsIG5Vax20MIycOQYhiqyPNM6yfmefak1N59i4mvl9A0aBXkmj1vz8g==
X-Received: by 2002:adf:f5d0:0:b0:228:6ca8:21f2 with SMTP id k16-20020adff5d0000000b002286ca821f2mr6696624wrp.271.1663441069119;
        Sat, 17 Sep 2022 11:57:49 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c510200b003a5b6086381sm7129223wms.48.2022.09.17.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 11:57:48 -0700 (PDT)
Message-ID: <632618ac.050a0220.bda86.d7a8@mx.google.com>
X-Google-Original-Message-ID: <YyYYqO1R2/bXfTIO@Ansuel-xps.>
Date:   Sat, 17 Sep 2022 20:57:44 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Marc Herbert <marc.herbert@intel.com>,
        James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 2/5] dt-bindings: arm: msm: Convert kpss-acc driver
 Documentation to yaml
References: <20220914142256.28775-3-ansuelsmth@gmail.com>
 <20220916191715.GA1079300-robh@kernel.org>
 <6324d1be.050a0220.9d842.7b47@mx.google.com>
 <CAA8EJprEQOsm4TxGWJYZo04D1PagT3QmhDdYQkEid-KSP-tpTw@mail.gmail.com>
 <6324d8e1.170a0220.aba35.ba4f@mx.google.com>
 <CAA8EJpowLvkuiYupqS0WEhnMR8q=R1YUUFgdFVCAx1PXyoo1xw@mail.gmail.com>
 <6324dc1b.df0a0220.97787.083c@mx.google.com>
 <CAA8EJpo08WoQ_LYOtg5C2BB=Q6GR_cftLjaWHWjYD6BjfDZcsg@mail.gmail.com>
 <6324f087.1c0a0220.7123d.8665@mx.google.com>
 <CAA8EJprhLUybqmPhFmit6LGaNOxz=-9+8xADXowJuzU5BtjjtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprhLUybqmPhFmit6LGaNOxz=-9+8xADXowJuzU5BtjjtA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 04:45:21PM +0300, Dmitry Baryshkov wrote:
> On Sat, 17 Sept 2022 at 00:54, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Fri, Sep 16, 2022 at 11:31:49PM +0300, Dmitry Baryshkov wrote:
> > > On Fri, 16 Sept 2022 at 23:27, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > >
> > > > On Fri, Sep 16, 2022 at 11:22:17PM +0300, Dmitry Baryshkov wrote:
> > > > > On Fri, 16 Sept 2022 at 23:13, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Sep 16, 2022 at 11:06:35PM +0300, Dmitry Baryshkov wrote:
> > > > > > > On Fri, 16 Sept 2022 at 22:43, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Sep 16, 2022 at 02:17:15PM -0500, Rob Herring wrote:
> > > > > > > > > On Wed, Sep 14, 2022 at 04:22:53PM +0200, Christian Marangi wrote:
> > > > > > > > > > Convert kpss-acc driver Documentation to yaml.
> > > > > > > > > > The original Documentation was wrong all along. Fix it while we are
> > > > > > > > > > converting it.
> > > > > > > > > > The example was wrong as kpss-acc-v2 should only expose the regs but we
> > > > > > > > > > don't have any driver that expose additional clocks. The kpss-acc driver
> > > > > > > > > > is only specific to v1. For this exact reason, limit all the additional
> > > > > > > > > > bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> > > > > > > > > > v1 and also flag that these bindings should NOT be used for v2.
> > > > > > > > >
> > > > > > > > > Odd that a clock controller has no clocks, but okay.
> > > > > > > > >
> > > > > > > >
> > > > > > > > As said in the commit v2 is only used for regs. v2 it's only used in
> > > > > > > > arch/arm/mach-qcom/platsmp.c to setup stuff cpu hotplug and bringup.
> > > > > > > >
> > > > > > > > Should we split the 2 driver? To me the acc naming seems to be just
> > > > > > > > recycled for v2 and it's not really a clk controller.
> > > > > > > >
> > > > > > > > So keeping v2 in arm/msm/qcom,kpss-acc-v2.yaml and v1 moved to clock?
> > > > > > >
> > > > > > > I suspect that qcom,kpss-acc-v2 is misnamed as the "clock-controller".
> > > > > > > According to msm-3.10, these regions are used by the Krait core
> > > > > > > regulators.
> > > > > > >
> > > > > >
> > > > > > Well we need to understand how to handle this... change the compatible
> > > > > > it's a nono for sure. In platsmp.c they are used for cpu power control
> > > > > > so could be that they are actually used to regulators. I would honestly
> > > > > > move v1 to clock and leave v2 to arm/msm but I'm not cetain on what name
> > > > > > to assign to the 2 yaml.
> > > > > >
> > > > > > What do you think?
> > > > >
> > > > > This is fine for me. If somebody gets better understanding of
> > > > > underlying hardware and works on actually using these blocks, he will
> > > > > update the bindings.
> > > > >
> > > > > My only suggestion would be to rename kpss-acc-v2 nodes to
> > > > > 'power-controller@address' and document them so.
> > > > >
> > > >
> > > > Ok so something like this?
> > > >
> > > >     power-controller@f9088000 {
> > > >       compatible = "qcom,kpss-acc-v2";
> > > >       reg = <0xf9088000 0x1000>,
> > > >             <0xf9008000 0x1000>;
> > > >     };
> > > >
> > > > (and I will have to fix dtbs warning as they will be unmatched I think.)
> > > > Yaml naming:
> > > > qcom,kpss-acc-v1.yaml
> > > > qcom,kpss-acc-v2.yaml
> > > > Right?
> > >
> > > Sounds good to me.
> > >
> > > I'd even say clock/qcom,kpss-acc-v1.yaml and
> > > arm/msm/qcom,kpss-acc-v2.yaml or maybe power/qcom,kpss-acc-v2.yaml
> > >
> >
> > Wonder if the gcc driver should have the same tretement? It's also a
> > clock-controller driver that doesn't use clock at all... Do you have
> > some info about it?
> 
> As far as I understand, the kpss-gcc is a normal clock controller,
> isn't it? It provides clocks to other devices.
> 

Hi again... Having acc-v2 as power-controller would require to set
#power-domain-cells = <0>;

Would that be acceptable? Considering it wouldn't expose any PM domain?

About kpss-gcc we have some device that for some reason doesn't have the
required clocks defined in the dts. I checked the related gcc and no PXO
defined and no pll8_vote clock defined. (the affected dts are all listed
in the related Documentation)

No idea how they currently work with the kpss-gcc driver as these
parents are missing. Guess the driver just fails to probe?
So this was the question if you had more info about it... since to me it
seems just another gcc v2 that doesn't expose clocks but it's just a
power-controller just like acc-v2. 

-- 
	Ansuel
