Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA16DBEBB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 07:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjDIFSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 01:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIFSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 01:18:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6CB4681;
        Sat,  8 Apr 2023 22:18:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94a34d34fcfso42497366b.2;
        Sat, 08 Apr 2023 22:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681017529; x=1683609529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWzsHmFTsiaq+FneBSH/AIWJGL7w8YvOi69R91dSNa0=;
        b=KuvZi04ZpXTayRLEwKZmLOPlLbianewIJBv2eFCbNgUdoDpyE5XDEmajhrZa61bCMr
         i9Hd4s+Q51V8nAOA4eGbZFAVmUoUUvcqhvPzkYgvNSTeggC2mfe7/E4mSn/+nBme5NFg
         CffBmvb0m145RobIJAJJKU7WTfAFp+JHt+RUhQRFkjck3mxVlQ3APB164gVXU0gC3uby
         oOmbWsuZWy9P/S/hX9iqRvFl3tmnyeUAdR8UB2ZOdlX4GkVls8O72MYETrcY4gQRHdUh
         mKeqah8NV3aS9vMQpy9sptLytJmU5snCpgxe06hSqAJV1vE/L+i8PHj3875UJeum+yj/
         t3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681017529; x=1683609529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWzsHmFTsiaq+FneBSH/AIWJGL7w8YvOi69R91dSNa0=;
        b=5y/AejhK5q5WA9Vr5RMpdf0Zi1AbQJu1vYc48xwRb+R+W1VW81WAlIYwaIj4bUG97p
         uJUmL9nllUSvcMCnfsrDYHRgVCluakj/o7ec91hGTOSIqseQdDBF8fWHoMnCU/HH1QQL
         Hc5TrOjYa7M7D0xwZVkk50NrBeEZdOZCMeyIY8KkDFO3IWbyKa9GhutWeqzXCG4dCgYR
         Ga0GwXUha1Dp2Y8GcNqln2V73V7sk2DtncuuL+h8cBFsuikxpxHdpm5C39N/lFZqOq6d
         ucf1W+gw9QozVGHjU/LJfGznlSujKEkPuWHLdjiBU0eQVj7UYJPIG53q+sH50ngKVCW+
         CpSA==
X-Gm-Message-State: AAQBX9epxtLHddemPpF/Dmk+sh1rqk+dAT4d4KC9jl1LqM2m93o7pxKl
        iAcwBgtfOvK0W6AOc12+fnY=
X-Google-Smtp-Source: AKy350YpKZlVxKMGgqChtL+x06xB+HKUfuCkDHHkqVaVaNxd9109cJXAB18UcXYtH/+Cw3i9yidY9Q==
X-Received: by 2002:a50:ed99:0:b0:4ab:d1f4:4b88 with SMTP id h25-20020a50ed99000000b004abd1f44b88mr6569670edr.41.1681017529329;
        Sat, 08 Apr 2023 22:18:49 -0700 (PDT)
Received: from [192.168.1.45] (hst-221-10.medicom.bg. [84.238.221.10])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709062f9100b009331450d04esm3817424eji.178.2023.04.08.22.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 22:18:49 -0700 (PDT)
Message-ID: <6c3002ad-ff78-8818-0e68-a151d33b0fca@gmail.com>
Date:   Sun, 9 Apr 2023 08:18:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] venus: add firmware version based check
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Viswanath Boma <quic_vboma@quicinc.com>
References: <1680848758-3947-1-git-send-email-quic_dikshita@quicinc.com>
 <1680848758-3947-2-git-send-email-quic_dikshita@quicinc.com>
Content-Language: en-US, bg-BG
From:   Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
In-Reply-To: <1680848758-3947-2-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dikshita,

Thanks for the patch.

On 7.04.23 г. 9:25 ч., Dikshita Agarwal wrote:
> Add firmware version based checks to enable/disable
> features for different SOCs.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
> Tested-by: Nathan Hebert <nhebert@chromium.org>
> ---
>   drivers/media/platform/qcom/venus/core.h     | 20 ++++++++++++++++++++
>   drivers/media/platform/qcom/venus/hfi_msgs.c | 11 +++++++++--
>   2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 32551c2..9d1e4b2 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -202,6 +202,11 @@ struct venus_core {
>   	unsigned int core0_usage_count;
>   	unsigned int core1_usage_count;
>   	struct dentry *root;
> +	struct venus_img_version {
> +		u32 major;
> +		u32 minor;
> +		u32 rev;
> +	} venus_ver;
>   };
>   
>   struct vdec_controls {
> @@ -500,4 +505,19 @@ venus_caps_by_codec(struct venus_core *core, u32 codec, u32 domain)
>   	return NULL;
>   }
>   
> +static inline int
> +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
> +{
> +	return ((core)->venus_ver.major == vmajor &&
> +		(core)->venus_ver.minor == vminor &&
> +		(core)->venus_ver.rev >= vrev);
> +}
> +
> +static inline int
> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
> +{
> +	return ((core)->venus_ver.major == vmajor &&
> +		(core)->venus_ver.minor == vminor &&
> +		(core)->venus_ver.rev <= vrev);
> +}

IMO those two should return bool

>   #endif
> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
> index df96db3..07ac0fc 100644
> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
> @@ -248,9 +248,10 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
>   }
>   
>   static void
> -sys_get_prop_image_version(struct device *dev,
> +sys_get_prop_image_version(struct venus_core *core,
>   			   struct hfi_msg_sys_property_info_pkt *pkt)
>   {
> +	struct device *dev = core->dev;
>   	u8 *smem_tbl_ptr;
>   	u8 *img_ver;
>   	int req_bytes;
> @@ -263,6 +264,12 @@ sys_get_prop_image_version(struct device *dev,
>   		return;
>   
>   	img_ver = pkt->data;
> +	if (IS_V4(core))
> +		sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u-PROD",
> +		       &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
> +	else if (IS_V6(core))
> +		sscanf(img_ver, "14:VIDEO.VPU.%u.%u-%u-PROD",
> +		       &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
>   

what about if IS_V1?

>   	dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);

this will crash for v1.

>   
> @@ -286,7 +293,7 @@ static void hfi_sys_property_info(struct venus_core *core,
>   
>   	switch (pkt->property) {
>   	case HFI_PROPERTY_SYS_IMAGE_VERSION:
> -		sys_get_prop_image_version(dev, pkt);
> +		sys_get_prop_image_version(core, pkt);
>   		break;
>   	default:
>   		dev_dbg(dev, VDBGL "unknown property data\n");

-- 
regards,
Stan
