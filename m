Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B0860D7E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiJYX34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiJYX3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:29:52 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0559065E1;
        Tue, 25 Oct 2022 16:29:51 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g16so8793869qtu.2;
        Tue, 25 Oct 2022 16:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmnlBbMANFDxVmmG4z+BiB60oz+lx1MeSzu+Mh+tjyQ=;
        b=nUyj7ZnvQ9LHW4vTV7lmPRRrdGHhe6ln2fXTnK1s6swZRQmrfNlU9+QZvi7jdrKNmX
         wy0xt3YRu94KTLBocNygIbrkWWhKZ29vpUdSb53SA3XvWrix8+ODYQLOgBPz3nFk2zJS
         ZyrzXLpvPaAocNJlCFnKc5JNQWuy2s2QzAokyOqAUgqG0V6TjAD8hML2oXRG1EqS0NkM
         7pNJG1xiuPAtfLgME0t1zNm5YzzK+f0rioN5cvk4xaJdjlfj7bNf7AR3uXbUk4RuQcRs
         Hgm6matm5icxiYds3Uv8JaGAuQokIvKcagkuGp+TY+UFyc0UVT6b0gvvatZKX2r9aM1s
         LALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmnlBbMANFDxVmmG4z+BiB60oz+lx1MeSzu+Mh+tjyQ=;
        b=1MRRxS+BlZapNi2c/JDCbOPHBoYVHcnfTEeHZrFjg+X/2gtkq4NL8P1LkOHukKYrEv
         Mbw8FgtfqT4t63KBLR5UEwlvuz5vEgBN3PCoaWoNUv/7TARAtKxEb5Pjq+hvMwJu3dNr
         znPQKg9CJQdEZKmS/aYxTaa5YgRNSs8jlnzVWYeWsQKllDwNpIF9yCNbHFZV8OGRE1qH
         AimZxAlOwz1Sfvtci7ZjT0KZQClpOUMDzNfxVjsHd3H0b3a3I02b8UOXQnJdHIJfTp0R
         f1svzDEmb8cBDchL6Xrh8CIpvGf1W6jFzz4hl0Tk74D4OGyfdNx8avtUymTlz9OqQWCb
         g0gQ==
X-Gm-Message-State: ACrzQf0bbZ6bQd3NQI1mJqVl9hWxYY1Bu/KIgRusWs8wZ2iLq+xZ1H8Y
        kFboAwZqYhsT05yXPvP+dU0=
X-Google-Smtp-Source: AMsMyM53DmDnwTSU5qFLh6JkI1r7iCnhjT2EsyqdkZFqKggzPIkKwfOhQzYNptSTj8hQGRy0yXfs4Q==
X-Received: by 2002:a05:622a:1806:b0:39a:68be:5c with SMTP id t6-20020a05622a180600b0039a68be005cmr33907401qtc.327.1666740590017;
        Tue, 25 Oct 2022 16:29:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id dm10-20020a05620a1d4a00b006af0ce13499sm2977247qkb.115.2022.10.25.16.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 16:29:49 -0700 (PDT)
Message-ID: <c677b825-012d-8f7f-2de9-16dd9363666c@gmail.com>
Date:   Tue, 25 Oct 2022 16:29:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 6/7] mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Faiz Abbas <faiz_abbas@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <20221024175501.2265400-1-briannorris@chromium.org>
 <20221024105229.v3.6.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
 <5b91c0eb-52aa-8431-c286-81b7feae84ce@intel.com>
 <Y1hY57vkkOhybwE1@google.com>
 <6268199c-78ca-8f55-0377-c14bb0299443@gmail.com>
 <Y1higmSUMLsxvXyq@google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Y1higmSUMLsxvXyq@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 15:26, Brian Norris wrote:
> On Tue, Oct 25, 2022 at 02:53:46PM -0700, Florian Fainelli wrote:
>> On 10/25/22 14:45, Brian Norris wrote:
>>> On Tue, Oct 25, 2022 at 04:10:44PM +0300, Adrian Hunter wrote:
>>>> On 24/10/22 20:55, Brian Norris wrote:
>>>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>>>>> index 8f1023480e12..6a282c7a221e 100644
>>>>> --- a/drivers/mmc/host/sdhci_am654.c
>>>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>>
>>>>> @@ -378,7 +379,7 @@ static void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
>>>>>    	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>    	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>>>>> -	sdhci_reset(host, mask);
>>>>> +	sdhci_and_cqhci_reset(host, mask);
>>>>>    	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
>>>>>    		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>>>>
>>>> What about sdhci_reset in sdhci_am654_ops ?
>>>
>>> Oops, I think you caught a big fallacy in some of my patches: I assumed
>>> there was a single reset() implementation in a given driver (an unwise
>>> assumption, I realize). I see at least sdhci-brcmstb.c also has several
>>> variant ops that call sdhci_reset(), and I should probably convert them
>>> too.
>>
>> You got it right for sdhci-brcmstb.c because "supports-cqe" which gates the
>> enabling of CQE can only be found with the "brcm,bcm7216-sdhci" compatible
>> which implies using brcmstb_reset().
> 
> I don't see any in-tree device trees for these chips (which is OK), and
> that's not what the Documentation/ says, and AFAICT nothing in the
> driver is limiting other variants from specifying the "supports-cqe"
> flag in their (out-of-tree) device tree. The closest thing I see is that
> an *example* in brcm,sdhci-brcmstb.yaml shows "supports-cqe" only on
> brcm,bcm7216-sdhci -- but an example is not a binding agreement. Am I
> missing something?
> 
> Now of course, you probably know behind the scenes that there are no
> other sdhci-brcmstb-relevant controllers that "support cqe", but AFAICT
> I have no way of knowing that a priori. The driver and bindings give
> (too much?) flexibility.

Yes that is fair enough, I will amend the binding document to make it 
clearer that 'supports-cqe' only applies in case of "brcm,bcm7216-sdhci" 
and not for other compatibles.
-- 
Florian

