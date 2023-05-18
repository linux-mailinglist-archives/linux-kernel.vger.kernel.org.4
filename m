Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE961707DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjERKQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjERKPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:15:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21FB2724;
        Thu, 18 May 2023 03:15:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-965b8a969b3so206069566b.1;
        Thu, 18 May 2023 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684404928; x=1686996928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXEEerdAkr1QCgMKgcW59hKxsHfWew2NELcny5y4HhI=;
        b=qlFV0lL8x1s7ffDaRrTahlJv0Ohi8FXZelPwblFN05HLXReYQpM24b2RnFtDWwxzbG
         UyIenIaju9TxGDEXK7Y7jXNYthYzvMYuFVBdELr3HmTi8pNoIS1SusoKs9ZwFOgITq77
         xymLoxEflA3tRXqQ2Hmbct9W/kuhQW8TlvVc1XYCTDyiK/P/wtOmq8OjxVpHlITJVM+J
         8aAC6f93HpTYSVqOzAtMdBNTQw/jiiEH/vRMeFLmswSax4Gxhdbi0806PoLq6Z6NrKMK
         LFDFDBcGT+B8jAOh/n3y5s359BXq3SNTc5UhaecMgoodA4jxTznnJQ6ye7fealBf4r9U
         EOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684404928; x=1686996928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXEEerdAkr1QCgMKgcW59hKxsHfWew2NELcny5y4HhI=;
        b=f5NmUaq7M0+ewmQsYZg9CiRFHTkNj5MdVzF0bU4Uk2glLkALB7pC4OVmx878IXjgzT
         F15oVBDFW7bgi11E/d0BIDDXWcZ2beRjAJnvALi/wgIj7pTgvlRuxLUnTYHgBXmVe/5f
         Rt/hXjOr9YcK20zy+dbO8Mz6RYJdp1ILKeURHQaeDZ7aYZwB3+PAzalMN4TzaBC0frjH
         A1HBkwrPID4q+3WKya+rW/69HOWlwZwvA+C/21OB2UJPLm/+vW/ekm8J/M77LeCPSiPY
         Zi/MqnA4nzgFVsma+KXoOvtmeJO+gIRdjaKMs3hEXDG1+viU8YznjG4h9PzKHJSI/Qh5
         pIWQ==
X-Gm-Message-State: AC+VfDxg9gX2rdKgKl7uhJkVV6WPWyMEn2Bnwm5DKo9NBF9askPQ+tXU
        eG1wfLiUukm+dswQQ5G0ORw=
X-Google-Smtp-Source: ACHHUZ79HADNqk+3EqDSYSgjJfye72hTyyGuQDVmTo3BgZRFpTi4NahKOwRR9uvhIhuBZgV/zmGMZw==
X-Received: by 2002:a17:907:d21:b0:94a:57d1:5539 with SMTP id gn33-20020a1709070d2100b0094a57d15539mr5235763ejc.5.1684404928407;
        Thu, 18 May 2023 03:15:28 -0700 (PDT)
Received: from [192.168.3.32] (dh207-97-74.xnet.hr. [88.207.97.74])
        by smtp.gmail.com with ESMTPSA id w3-20020a170906d20300b0094ee700d8e4sm770744ejz.44.2023.05.18.03.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 03:15:27 -0700 (PDT)
Message-ID: <76943268-3982-deaf-9736-429dd51e01b0@gmail.com>
Date:   Thu, 18 May 2023 12:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3] firmware: qcom_scm: Clear download bit during reboot
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1678979666-551-1-git-send-email-quic_mojha@quicinc.com>
Content-Language: en-US
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <1678979666-551-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16. 03. 2023. 16:14, Mukesh Ojha wrote:
> During normal restart of a system download bit should
> be cleared irrespective of whether download mode is
> set or not.
>
> Fixes: 8c1b7dc9ba22 ("firmware: qcom: scm: Expose download-mode control")
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

Hi, this has been backported to 5.15.111, however it seems to be 
breaking reboot
on IPQ4019 by causing the board to then hang in SBL with:
root@OpenWrt:/# reboot
root@OpenWrt:/# [   76.473541] device lan1 left promiscuous mode
[   76.474204] br-lan: port 1(lan1) entered disabled state
[   76.527975] device lan2 left promiscuous mode
[   76.530301] br-lan: port 2(lan2) entered disabled state
[   76.579376] device lan3 left promiscuous mode
[   76.581698] br-lan: port 3(lan3) entered disabled state
[   76.638434] device lan4 left promiscuous mode
[   76.638777] br-lan: port 4(lan4) entered disabled state
[   76.978489] qca8k-ipq4019 c000000.switch wan: Link is Down
[   76.978883] device eth0 left promiscuous mode
[   76.987077] ipqess-edma c080000.ethernet eth0: Link is Down
[
Format: Log Type - Time(microsec) - Message - Optional Info
Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
S - QC_IMAGE_VERSION_STRING=BOOT.BF.3.1.1-00123
S - IMAGE_VARIANT_STRING=DAABANAZA
S - OEM_IMAGE_VERSION_STRING=CRM
S - Boot Config, 0x00000021
S - Reset status Config, 0x00000010
S - Core 0 Frequency, 0 MHz
B -       261 - PBL, Start
B -      1339 - bootable_media_detect_entry, Start
B -      1679 - bootable_media_detect_success, Start
B -      1693 - elf_loader_entry, Start
B -      5076 - auth_hash_seg_entry, Start
B -      7223 - auth_hash_seg_exit, Start
B -    578349 - elf_segs_hash_verify_entry, Start
B -    696356 - PBL, End
B -    696380 - SBL1, Start
B -    787236 - pm_device_init, Start
D -         7 - pm_device_init, Delta
B -    788701 - boot_flash_init, Start
D -     52782 - boot_flash_init, Delta
B -    845625 - boot_config_data_table_init, Start
D -      3836 - boot_config_data_table_init, Delta - (419 Bytes)
B -    852841 - clock_init, Start
D -      7566 - clock_init, Delta
B -    864883 - CDT version:2,Platform ID:9,Major ID:0,Minor ID:0,Subtype:64
B -    868413 - sbl1_ddr_set_params, Start
B -    873402 - cpr_init, Start
D -         2 - cpr_init, Delta
B -    877842 - Pre_DDR_clock_init, Start
D -         4 - Pre_DDR_clock_init, Delta
D -     13234 - sbl1_ddr_set_params, Delta
B -    891155 - pm_driver_init, Start
D -         2 - pm_driver_init, Delta
B -    909105 - Image Load, Start
B -   1030210 - Boot error ocuured!. Error code: 303d

Reverting the commit fixes rebooting.

Regards,
Robert

> ---
> Changes in v3:
>    - Added Fixes tag.
>    - Removed it from below patch series, as it makes sense to go this independently.
>      https://lore.kernel.org/lkml/1677664555-30191-1-git-send-email-quic_mojha@quicinc.com/
>
> Changes in v2:
>    - No change.
>
>   drivers/firmware/qcom_scm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 468d4d5..3e020d1 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1506,8 +1506,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   static void qcom_scm_shutdown(struct platform_device *pdev)
>   {
>   	/* Clean shutdown, disable download mode to allow normal restart */
> -	if (download_mode)
> -		qcom_scm_set_download_mode(false);
> +	qcom_scm_set_download_mode(false);
>   }
>   
>   static const struct of_device_id qcom_scm_dt_match[] = {
