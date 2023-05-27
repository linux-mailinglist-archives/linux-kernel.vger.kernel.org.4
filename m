Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0057132BF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 08:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjE0GCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 02:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjE0GCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 02:02:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95009E;
        Fri, 26 May 2023 23:02:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96f818c48fbso268323266b.0;
        Fri, 26 May 2023 23:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685167335; x=1687759335;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SYUbUzRDyKvBWuzAZ60BWsZvsAhZJCrWfsLAi7Apk0g=;
        b=Pq8+Zk+Q89/G4e8/TqXAQndtXf6O0j3qOxfkjBGXaHmt1zL0H3uayA4pwyiD6DobRL
         AaocUawS2IvakUsLBS11BnOLQrbrtz96iofUxrZzpoywsRRaLxy38hlbw3JBEF8nK3Cl
         OnVgMjVFrQxqtLrxSNTpyHkT8TSntIOTNWPd86tjlsAJYwCWZIWie+/J99MD/pOCzRCD
         DHeJWRICgz+RRUae9x7k7LzMLxwZX2+po/JzpDz5teiBLhxGYRTNOjKxGJYxAp8qDxJG
         mOg+P5fQ0higxUXTyE2elDfkhueHsrUwMa2yZvlBIbEyce4TSI5wTvPybwplbWR0icla
         OB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685167335; x=1687759335;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYUbUzRDyKvBWuzAZ60BWsZvsAhZJCrWfsLAi7Apk0g=;
        b=HYMf69r1uEHzkAcfHjh2QaMGdY5BffsPH8b4QhFr05dyMh9kQiH6dw+pzgoIxJwu/I
         z1EHc2H5HteTXhV6+ndpNnxMipN9BEVX2Qt0dR6MV6p75x7XgYm1J9wdUDBWTLreaIWH
         dOgaWOW7rDZAnt7d0r3PcpJ/bUpHUDTk4MmTeyVMtjxxwMuFw0cMtWpkp3HoRyL4a15e
         OqQ3alh6LuSpX8DwtBkTAirbtw9yXSFPvC7MDdEI75+3/ARpGYQhivN9tBnxdjXlZvTL
         jlLFuAPCWQmYM0/frRJOHgUzzcZ34mwk6CeL3ph3SGkJaxuI/+95daLho6lpW2IhuXfa
         Hkvw==
X-Gm-Message-State: AC+VfDyxwHKYAJPk9TPE4bDrL6qNbzTXxQqU/lmGk63oFTBn9RSKQy5s
        1R85SSCB7305v5tghY9MTU0=
X-Google-Smtp-Source: ACHHUZ52puV6wtFPC8NjAMgbGrTCkjqSX/kEsC59aXlEtIjeBQO5msXVUKP487UYvie13tlJt9sfkw==
X-Received: by 2002:a17:907:97c6:b0:96f:4225:9009 with SMTP id js6-20020a17090797c600b0096f42259009mr4000794ejc.0.1685167335098;
        Fri, 26 May 2023 23:02:15 -0700 (PDT)
Received: from [192.168.94.52] ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id x19-20020a1709064a9300b0096616adc0d5sm3004547eju.104.2023.05.26.23.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 23:02:14 -0700 (PDT)
Date:   Sat, 27 May 2023 09:02:04 +0300
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH v2 3/3] media: camss: Link CAMSS power domain
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <GFZAVR.8RI43MBQZ4HN3@gmail.com>
In-Reply-To: <fa395680-0e6c-3eb0-9d5a-f90a95c394b8@linaro.org>
References: <20230526180712.8481-1-y.oudjana@protonmail.com>
        <20230526180712.8481-4-y.oudjana@protonmail.com>
        <fa395680-0e6c-3eb0-9d5a-f90a95c394b8@linaro.org>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, May 26 2023 at 09:49:30 PM +01:00:00, Bryan O'Donoghue 
<bryan.odonoghue@linaro.org> wrote:
> On 26/05/2023 19:07, Yassine Oudjana wrote:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>> The CAMSS power domain was previously enabled implicitly when the VFE
>> power domains were enabled.
>> Commit 46cc03175498 ("media: camss: Split power domain management")
>> delayed enabling VFE power domains which in turn delayed enabling the
>> CAMSS power domain. This made CSIPHY fail to enable camss_top_ahb_clk
>> which requires the CAMSS power domain to be on:
>> 
>> [  199.097810] ------------[ cut here ]------------
>> [  199.097893] camss_top_ahb_clk status stuck at 'off'
>> [  199.097913] WARNING: CPU: 3 PID: 728 at 
>> drivers/clk/qcom/clk-branch.c:91 clk_branch_wait+0x140/0x160
>> ...
>> [  199.100064]  clk_branch_wait+0x140/0x160
>> [  199.100112]  clk_branch2_enable+0x30/0x40
>> [  199.100159]  clk_core_enable+0x6c/0xb0
>> [  199.100211]  clk_enable+0x2c/0x50
>> [  199.100257]  camss_enable_clocks+0x94/0xe0 [qcom_camss]
>> [  199.100342]  csiphy_set_power+0x154/0x2a0 [qcom_camss]
>> ...
>> [  199.101594] ---[ end trace 0000000000000000 ]---
>> 
>> Link the CAMSS power domain in camss_configure_pd to make sure it 
>> gets
>> enabled before CSIPHY tries to enable clocks.
>> 
>> Fixes: 02afa816dbbf ("media: camss: Add basic runtime PM support")
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> ---
>>   drivers/media/platform/qcom/camss/camss.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/media/platform/qcom/camss/camss.c 
>> b/drivers/media/platform/qcom/camss/camss.c
>> index 1ef26aea3eae..9aea8220d923 100644
>> --- a/drivers/media/platform/qcom/camss/camss.c
>> +++ b/drivers/media/platform/qcom/camss/camss.c
>> @@ -1453,6 +1453,7 @@ static const struct media_device_ops 
>> camss_media_ops = {
>>   static int camss_configure_pd(struct camss *camss)
>>   {
>>   	struct device *dev = camss->dev;
>> +	int camss_pd_index;
>>   	int i;
>>   	int ret;
>>   @@ -1496,7 +1497,13 @@ static int camss_configure_pd(struct camss 
>> *camss)
>>   		}
>>   	}
>>   -	if (i > camss->vfe_num) {
>> +	/* Link CAMSS power domain if available */
>> +	camss_pd_index = device_property_match_string(camss->dev, 
>> "power-domain-names", "camss");
>> +	if (camss_pd_index >= 0)
>> +		device_link_add(camss->dev, camss->genpd[camss_pd_index], 
>> DL_FLAG_STATELESS |
>> +				DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
>> +
>> +	if (i > camss->vfe_num && i != camss_pd_index) {
>>   		camss->genpd_link[i - 1] = device_link_add(camss->dev, 
>> camss->genpd[i - 1],
>>   							   DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME |
>>   							   DL_FLAG_RPM_ACTIVE);
> 
> Konrad pointed this out.
> 
> Are you 100% sure you want to do this. We already have a way to count 
> the # of power-domains in camss_configure_pd().
> 
> Your series is now adding a dependency on power-domain-names.
> 
> Is there a good reason to add that dependency ? If not, then lets 
> just take the code from camss_configure_pd() and make it so that it 
> can be used/reused here.

Is there a good reason not to? I found that using the existing 
index-based method would unnecessarily complicate things since an extra 
layer of checks would be needed to differentiate between MSM8996 and 
TITAN SoCs, since those have the TITAN GDSC at the same index where the 
CAMSS GDSC is now added for MSM8996. The same checks will also have to 
be repeated in error paths and during cleanup.

I guessed the only reason we were still using this method for the 
existing PDs was to remain compatible with old DT as Konrad mentioned, 
and since this CAMSS PD is only added now, I thought it'd be a good 
opportunity to introduce power-domain-names and simplify things a bit.

> ---
> bod


