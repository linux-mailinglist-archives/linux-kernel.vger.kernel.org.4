Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EEF707EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjERLCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjERLCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:02:04 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181D9E8;
        Thu, 18 May 2023 04:02:03 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-52cb78647ecso1249939a12.1;
        Thu, 18 May 2023 04:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684407722; x=1686999722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHadosSVP1nYeUYor3LYCwEiSQu4WLzAMj39s4WmEiE=;
        b=b2cQDMUYRU9sxfpMR/P4TVHYY/bVcXfROWLkpgM+keixBcZ0W7q+pABMmJekvpJccq
         9BqAxS22ZtWWAzt35MCNz4Rzf7FYIJ3ut1MwIgmSDrVVCN3nPfCxEN52az9nHhWje+n/
         +hwHfViwXxX4HWvdZorfM5/kb1EeAfI57NZfZEHkdPjXEWzdnrZMhUKWR8rsDgQXuMVF
         HBQp3ClIR+GlF/s/dwxCeiIRbh2Rsj9yJpVoLTrudVrrIEAX4psuzGgEDT3PrGGvExh5
         ew+zw6IrrNs45JW+MJXI2uLZ4Di4R42vYzr1Ztcx5GdNFcA6VKopMeyD21sCaNndNw81
         wiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684407722; x=1686999722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHadosSVP1nYeUYor3LYCwEiSQu4WLzAMj39s4WmEiE=;
        b=coDEYRQqnac01uqiRlAnFJ6RVEXDWu2ubUYwt22oSAWQcLqqupxOHI25YA7jUTm7rF
         c8goGiGAzonYmjMVn2lSUQ13beyJ+qd+bW7UVogwuBQcqJV/+9EdxcY6DmjeDdHeynVl
         cK7spQfNXIqOnhwUN9BSGUiXUCBaSy4q/4F5M59n/2f/3Ipfp5JbhrrjrQFWXSuNNcYt
         Fqvk8kQO3ZIeqMrxW+qBGCdODjosYf2S4SVYqMNZ8uiNpYurFZzRjt0S+6+IImmPGCuR
         v9XfbHfYw/mFF9UvLw2WoSFEIooZHrcxkn6n+OJqph29ZG6W/Bge8SDoGd4dVI5GyGDR
         fJEQ==
X-Gm-Message-State: AC+VfDxiJnaVcjLikdtNXPxo8aoVOnvy1kaLHrVCA9Nm2Tw2OhEqD8mX
        Axa5MVHwjXHRVlkWujiykCU9BUyZirU4ja6zbug=
X-Google-Smtp-Source: ACHHUZ6QeMDKQ8o8d5u/L+MqMx0fcWHl7nyy9+bo9SijSMzn68BRMxKaYwM2W5mQz6LVCG+qibygS5qbq1DqOw2Xc5M=
X-Received: by 2002:a17:902:7b8f:b0:1ae:2e0f:1cf6 with SMTP id
 w15-20020a1709027b8f00b001ae2e0f1cf6mr2036475pll.36.1684407722440; Thu, 18
 May 2023 04:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <1678979666-551-1-git-send-email-quic_mojha@quicinc.com>
 <76943268-3982-deaf-9736-429dd51e01b0@gmail.com> <052bacf7-756b-5f63-965b-9a8480a9acf5@quicinc.com>
In-Reply-To: <052bacf7-756b-5f63-965b-9a8480a9acf5@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Thu, 18 May 2023 13:01:51 +0200
Message-ID: <CAOX2RU4WcNXu42W6_459wKzyo+6onNRhE+=3usmSRB9AEF3MtA@mail.gmail.com>
Subject: Re: [PATCH v3] firmware: qcom_scm: Clear download bit during reboot
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 at 12:44, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
>
>
> On 5/18/2023 3:45 PM, Robert Marko wrote:
> >
> > On 16. 03. 2023. 16:14, Mukesh Ojha wrote:
> >> During normal restart of a system download bit should
> >> be cleared irrespective of whether download mode is
> >> set or not.
> >>
> >> Fixes: 8c1b7dc9ba22 ("firmware: qcom: scm: Expose download-mode control")
> >> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> >
> > Hi, this has been backported to 5.15.111, however it seems to be
> > breaking reboot
>
> Thanks for reporting the issue, by any chance enabling
> CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT + reboot works on
> IPQ4019 ?

Unfortunately not, the board still hangs in SBL.

Regards,
Robert

>
> > on IPQ4019 by causing the board to then hang in SBL with:
> > root@OpenWrt:/# reboot
> > root@OpenWrt:/# [   76.473541] device lan1 left promiscuous mode
> > [   76.474204] br-lan: port 1(lan1) entered disabled state
> > [   76.527975] device lan2 left promiscuous mode
> > [   76.530301] br-lan: port 2(lan2) entered disabled state
> > [   76.579376] device lan3 left promiscuous mode
> > [   76.581698] br-lan: port 3(lan3) entered disabled state
> > [   76.638434] device lan4 left promiscuous mode
> > [   76.638777] br-lan: port 4(lan4) entered disabled state
> > [   76.978489] qca8k-ipq4019 c000000.switch wan: Link is Down
> > [   76.978883] device eth0 left promiscuous mode
> > [   76.987077] ipqess-edma c080000.ethernet eth0: Link is Down
> > [
> > Format: Log Type - Time(microsec) - Message - Optional Info
> > Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> > S - QC_IMAGE_VERSION_STRING=BOOT.BF.3.1.1-00123
> > S - IMAGE_VARIANT_STRING=DAABANAZA
> > S - OEM_IMAGE_VERSION_STRING=CRM
> > S - Boot Config, 0x00000021
> > S - Reset status Config, 0x00000010
> > S - Core 0 Frequency, 0 MHz
> > B -       261 - PBL, Start
> > B -      1339 - bootable_media_detect_entry, Start
> > B -      1679 - bootable_media_detect_success, Start
> > B -      1693 - elf_loader_entry, Start
> > B -      5076 - auth_hash_seg_entry, Start
> > B -      7223 - auth_hash_seg_exit, Start
> > B -    578349 - elf_segs_hash_verify_entry, Start
> > B -    696356 - PBL, End
> > B -    696380 - SBL1, Start
> > B -    787236 - pm_device_init, Start
> > D -         7 - pm_device_init, Delta
> > B -    788701 - boot_flash_init, Start
> > D -     52782 - boot_flash_init, Delta
> > B -    845625 - boot_config_data_table_init, Start
> > D -      3836 - boot_config_data_table_init, Delta - (419 Bytes)
> > B -    852841 - clock_init, Start
> > D -      7566 - clock_init, Delta
> > B -    864883 - CDT version:2,Platform ID:9,Major ID:0,Minor
> > ID:0,Subtype:64
> > B -    868413 - sbl1_ddr_set_params, Start
> > B -    873402 - cpr_init, Start
> > D -         2 - cpr_init, Delta
> > B -    877842 - Pre_DDR_clock_init, Start
> > D -         4 - Pre_DDR_clock_init, Delta
> > D -     13234 - sbl1_ddr_set_params, Delta
> > B -    891155 - pm_driver_init, Start
> > D -         2 - pm_driver_init, Delta
> > B -    909105 - Image Load, Start
> > B -   1030210 - Boot error ocuured!. Error code: 303d
> >
> > Reverting the commit fixes rebooting.
> >
> > Regards,
> > Robert
> >
> >> ---
> >> Changes in v3:
> >>    - Added Fixes tag.
> >>    - Removed it from below patch series, as it makes sense to go this
> >> independently.
> >>
> >> https://lore.kernel.org/lkml/1677664555-30191-1-git-send-email-quic_mojha@quicinc.com/
> >>
> >> Changes in v2:
> >>    - No change.
> >>
> >>   drivers/firmware/qcom_scm.c | 3 +--
> >>   1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> >> index 468d4d5..3e020d1 100644
> >> --- a/drivers/firmware/qcom_scm.c
> >> +++ b/drivers/firmware/qcom_scm.c
> >> @@ -1506,8 +1506,7 @@ static int qcom_scm_probe(struct platform_device
> >> *pdev)
> >>   static void qcom_scm_shutdown(struct platform_device *pdev)
> >>   {
> >>       /* Clean shutdown, disable download mode to allow normal restart */
> >> -    if (download_mode)
> >> -        qcom_scm_set_download_mode(false);
> >> +    qcom_scm_set_download_mode(false);
> >>   }
> >>   static const struct of_device_id qcom_scm_dt_match[] = {
