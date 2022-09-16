Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5875BB350
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiIPUN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiIPUNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:13:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE5CAD9A7;
        Fri, 16 Sep 2022 13:13:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sb3so22261107ejb.9;
        Fri, 16 Sep 2022 13:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date;
        bh=BuQxitJhdTQh9KhMErUj9P+9zMVr60WmdCStuMhHGJU=;
        b=Q+EtoZeH2gcdOLQ90dl6pt6+LlaxSpR3is8AWmjykbiuE/rzTdy19XLiKZWxozKRkL
         CcAkRT3cXrm+lwpoqYZIyTLXyJR7nRejJcWgH+MPX2I7cTGtfNNL5D5BjVivlkF4PFVV
         PtOV0E6GwbPhsON1aRbRxgqzOx4oeQeTnWrvFGvAIPAekwPQeL3vzdLtYLxfUoGVjNiV
         Er3GbnF9Gm5FfjTu+lNSECkHuNAvIQDVypC6e7RJvVJ+ZHgNnl6PRlUVShwWOH/fJjK8
         PLdmMx1ECZCCJ76xmzH++0x9mhJWtFdK+DsdbXIuiPbNExdI/+xTdNGDarCsnqO/Jh6k
         2rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=BuQxitJhdTQh9KhMErUj9P+9zMVr60WmdCStuMhHGJU=;
        b=gcEWty3yy2kNv/ok2ZKWoou5C5jw+d5BvwWkB3ko3+AdTLV6s6aRIuK8V0Z7q0B4CN
         NeAsQq6g5AxVxPpyKoeiZ/5Mvrhd88MW/48R4SIMJtXE+fJq3n9FONvFs+2rUHhB2iRO
         93mOPoek6xYaW0JgqTQeN/5vUtEqie4d1/CEHSdqrTLFy/RKQ6H0itwDoCdlF/+4g2GX
         o0DV5Da2jSx9S6+t+h1NQE/n6JqQogxbLB/KDrlHvedrSEljmMWcna8PeMDIbqcL7Rch
         v+SJ6kdcuBn0p3dexn7BoT1OR3g2UYYwX/2K5tPil+SsiXOXOIKSA1e8O6UIfnR1nuJY
         yPKA==
X-Gm-Message-State: ACrzQf31iwlAbiEd2k62qb+cRQpWpDcsAHzjqZXUBnZFc1cnvs8dau5U
        howNmZ1PmBqoHHNDGnUvb0ZGvEjzSlo=
X-Google-Smtp-Source: AMsMyM59nAtMUDMOEeX8JJQXJl6uFv2RZwS4ChgiUu+dWFxy15ZaSFAJ9Usl/S9X3KgcScyrX9qUKA==
X-Received: by 2002:a17:907:8a03:b0:77f:f5ac:8b46 with SMTP id sc3-20020a1709078a0300b0077ff5ac8b46mr4850480ejc.65.1663359201536;
        Fri, 16 Sep 2022 13:13:21 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.gmail.com with ESMTPSA id kw22-20020a170907771600b0077b2b0563f4sm10252803ejc.173.2022.09.16.13.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 13:13:21 -0700 (PDT)
Message-ID: <6324d8e1.170a0220.aba35.ba4f@mx.google.com>
X-Google-Original-Message-ID: <YyTY3bQoRVdLLxnE@Ansuel-xps.>
Date:   Fri, 16 Sep 2022 22:13:17 +0200
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
References: <20220914142256.28775-1-ansuelsmth@gmail.com>
 <20220914142256.28775-3-ansuelsmth@gmail.com>
 <20220916191715.GA1079300-robh@kernel.org>
 <6324d1be.050a0220.9d842.7b47@mx.google.com>
 <CAA8EJprEQOsm4TxGWJYZo04D1PagT3QmhDdYQkEid-KSP-tpTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprEQOsm4TxGWJYZo04D1PagT3QmhDdYQkEid-KSP-tpTw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 11:06:35PM +0300, Dmitry Baryshkov wrote:
> On Fri, 16 Sept 2022 at 22:43, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Fri, Sep 16, 2022 at 02:17:15PM -0500, Rob Herring wrote:
> > > On Wed, Sep 14, 2022 at 04:22:53PM +0200, Christian Marangi wrote:
> > > > Convert kpss-acc driver Documentation to yaml.
> > > > The original Documentation was wrong all along. Fix it while we are
> > > > converting it.
> > > > The example was wrong as kpss-acc-v2 should only expose the regs but we
> > > > don't have any driver that expose additional clocks. The kpss-acc driver
> > > > is only specific to v1. For this exact reason, limit all the additional
> > > > bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> > > > v1 and also flag that these bindings should NOT be used for v2.
> > >
> > > Odd that a clock controller has no clocks, but okay.
> > >
> >
> > As said in the commit v2 is only used for regs. v2 it's only used in
> > arch/arm/mach-qcom/platsmp.c to setup stuff cpu hotplug and bringup.
> >
> > Should we split the 2 driver? To me the acc naming seems to be just
> > recycled for v2 and it's not really a clk controller.
> >
> > So keeping v2 in arm/msm/qcom,kpss-acc-v2.yaml and v1 moved to clock?
> 
> I suspect that qcom,kpss-acc-v2 is misnamed as the "clock-controller".
> According to msm-3.10, these regions are used by the Krait core
> regulators.
>

Well we need to understand how to handle this... change the compatible
it's a nono for sure. In platsmp.c they are used for cpu power control
so could be that they are actually used to regulators. I would honestly
move v1 to clock and leave v2 to arm/msm but I'm not cetain on what name
to assign to the 2 yaml.

What do you think?

-- 
	Ansuel
