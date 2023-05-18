Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62668707F58
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjERLcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjERLcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:32:22 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A631BD9;
        Thu, 18 May 2023 04:32:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ae3a5dfa42so14588455ad.0;
        Thu, 18 May 2023 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684409520; x=1687001520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DrUhtpEhCOWdq4nrF3tdFYRY0I71dUu2973w4b86mBc=;
        b=sKxXEYevBNZMPYV6722k37oxcV2vhqUMutnc5MdPrKLgF+fpfQ+9uhGspP7d7TfO27
         BGTp5zPvBT3qECQl95jgfUYWwq9qiyK/ekb3DsiVxdIzOJVB90isL/vWrNHpz5yiEimx
         0YaZqEICN4H4tmejhnYvAQi1ijm2oo1rbS8hERXN17ltYyy2npTy9vPuv3k906SHfbk9
         K+agdKtXQhZQEzhyOSRujB6LnN4OSKQ+oFYuDvEGMD9zpv7o56Ju6t7PpFTsDZqWtkAG
         nnqc9+vgexg58ZeeeIUW6Mcz5tTAem4IKmDy+UcHNHE8DjcIex+UcR7XgDcReSE/aUZp
         tQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684409520; x=1687001520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrUhtpEhCOWdq4nrF3tdFYRY0I71dUu2973w4b86mBc=;
        b=XUP7l2DW+R4K4csdmz4xht5VyrcmAWWJyP4AXEZzdcmrOIUBwtWvwK+GnhGlu2szGo
         tXcuHK+wVnESC/kWX1/f62WKaOYS60SYoz0QtJOyB811KjOEIiOQ68cF9kuZuLMXJDLN
         bS+hKAnyMzh95uYRJdjiO+3rqxFfuK1DIYjz7ZrxYKuLuHvAT0YF3g0pHlnXKC4W5WJ3
         STw0YNb8O5LFxyruUNxTe0Jzj9MU44u1xGC1E5QXLnlKOllgIPpZ2yskrxPdiEBFf7Ct
         nzIqkJtSNC9lFnwWarp6MT5unvDYuoTg4l1cIc3getn1mO94YP7vMBNkpzZH8GRZNid6
         lfsA==
X-Gm-Message-State: AC+VfDynrCsnwGDDOf18+lFZyMFCM/+RxdygLr52fZmBCTJ9Asarti9k
        3RhCpOksUSRtNEjZ5jGyiPwO9xJnLG2t6vFHZ9M=
X-Google-Smtp-Source: ACHHUZ4/BtSYNZepqiHBj6+kKD6NpDeOLjIMaV48EAXzCvZ1CODv9Lr4Xtf6YAKoORbYA7VCvklxwPRAROwvSscYF2Y=
X-Received: by 2002:a17:902:6b85:b0:1aa:ff24:f8f0 with SMTP id
 p5-20020a1709026b8500b001aaff24f8f0mr2084927plk.4.1684409520256; Thu, 18 May
 2023 04:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <1678979666-551-1-git-send-email-quic_mojha@quicinc.com>
 <76943268-3982-deaf-9736-429dd51e01b0@gmail.com> <052bacf7-756b-5f63-965b-9a8480a9acf5@quicinc.com>
 <CAOX2RU4WcNXu42W6_459wKzyo+6onNRhE+=3usmSRB9AEF3MtA@mail.gmail.com> <9fbc7f18-1610-7a72-b135-daeca382847e@quicinc.com>
In-Reply-To: <9fbc7f18-1610-7a72-b135-daeca382847e@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Thu, 18 May 2023 13:31:49 +0200
Message-ID: <CAOX2RU7y_jfpXjZLWL+b84+36CMosyFsy7fPTvN6ZOMPQETpug@mail.gmail.com>
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

On Thu, 18 May 2023 at 13:28, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
>
>
> On 5/18/2023 4:31 PM, Robert Marko wrote:
> > On Thu, 18 May 2023 at 12:44, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 5/18/2023 3:45 PM, Robert Marko wrote:
> >>>
> >>> On 16. 03. 2023. 16:14, Mukesh Ojha wrote:
> >>>> During normal restart of a system download bit should
> >>>> be cleared irrespective of whether download mode is
> >>>> set or not.
> >>>>
> >>>> Fixes: 8c1b7dc9ba22 ("firmware: qcom: scm: Expose download-mode control")
> >>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> >>>
> >>> Hi, this has been backported to 5.15.111, however it seems to be
> >>> breaking reboot
> >>
> >> Thanks for reporting the issue, by any chance enabling
> >> CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT + reboot works on
> >> IPQ4019 ?
> >
> > Unfortunately not, the board still hangs in SBL.
>
> Sorry for the trouble, but looks like this change need to be
> reverted.
>
> I sent a patch for its revert.

Thanks for the quick action.

Regards,
Robert
>
> -- Mukesh
>
> >
> > Regards,
> > Robert
> >
> >>
> >>> on IPQ4019 by causing the board to then hang in SBL with:
> >>> root@OpenWrt:/# reboot
> >>> root@OpenWrt:/# [   76.473541] device lan1 left promiscuous mode
> >>> [   76.474204] br-lan: port 1(lan1) entered disabled state
> >>> [   76.527975] device lan2 left promiscuous mode
> >>> [   76.530301] br-lan: port 2(lan2) entered disabled state
> >>> [   76.579376] device lan3 left promiscuous mode
> >>> [   76.581698] br-lan: port 3(lan3) entered disabled state
> >>> [   76.638434] device lan4 left promiscuous mode
> >>> [   76.638777] br-lan: port 4(lan4) entered disabled state
> >>> [   76.978489] qca8k-ipq4019 c000000.switch wan: Link is Down
> >>> [   76.978883] device eth0 left promiscuous mode
> >>> [   76.987077] ipqess-edma c080000.ethernet eth0: Link is Down
> >>> [
> >>> Format: Log Type - Time(microsec) - Message - Optional Info
> >>> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> >>> S - QC_IMAGE_VERSION_STRING=BOOT.BF.3.1.1-00123
> >>> S - IMAGE_VARIANT_STRING=DAABANAZA
> >>> S - OEM_IMAGE_VERSION_STRING=CRM
> >>> S - Boot Config, 0x00000021
> >>> S - Reset status Config, 0x00000010
> >>> S - Core 0 Frequency, 0 MHz
> >>> B -       261 - PBL, Start
> >>> B -      1339 - bootable_media_detect_entry, Start
> >>> B -      1679 - bootable_media_detect_success, Start
> >>> B -      1693 - elf_loader_entry, Start
> >>> B -      5076 - auth_hash_seg_entry, Start
> >>> B -      7223 - auth_hash_seg_exit, Start
> >>> B -    578349 - elf_segs_hash_verify_entry, Start
> >>> B -    696356 - PBL, End
> >>> B -    696380 - SBL1, Start
> >>> B -    787236 - pm_device_init, Start
> >>> D -         7 - pm_device_init, Delta
> >>> B -    788701 - boot_flash_init, Start
> >>> D -     52782 - boot_flash_init, Delta
> >>> B -    845625 - boot_config_data_table_init, Start
> >>> D -      3836 - boot_config_data_table_init, Delta - (419 Bytes)
> >>> B -    852841 - clock_init, Start
> >>> D -      7566 - clock_init, Delta
> >>> B -    864883 - CDT version:2,Platform ID:9,Major ID:0,Minor
> >>> ID:0,Subtype:64
> >>> B -    868413 - sbl1_ddr_set_params, Start
> >>> B -    873402 - cpr_init, Start
> >>> D -         2 - cpr_init, Delta
> >>> B -    877842 - Pre_DDR_clock_init, Start
> >>> D -         4 - Pre_DDR_clock_init, Delta
> >>> D -     13234 - sbl1_ddr_set_params, Delta
> >>> B -    891155 - pm_driver_init, Start
> >>> D -         2 - pm_driver_init, Delta
> >>> B -    909105 - Image Load, Start
> >>> B -   1030210 - Boot error ocuured!. Error code: 303d
> >>>
> >>> Reverting the commit fixes rebooting.
> >>>
> >>> Regards,
> >>> Robert
> >>>
> >>>> ---
> >>>> Changes in v3:
> >>>>     - Added Fixes tag.
> >>>>     - Removed it from below patch series, as it makes sense to go this
> >>>> independently.
> >>>>
> >>>> https://lore.kernel.org/lkml/1677664555-30191-1-git-send-email-quic_mojha@quicinc.com/
> >>>>
> >>>> Changes in v2:
> >>>>     - No change.
> >>>>
> >>>>    drivers/firmware/qcom_scm.c | 3 +--
> >>>>    1 file changed, 1 insertion(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> >>>> index 468d4d5..3e020d1 100644
> >>>> --- a/drivers/firmware/qcom_scm.c
> >>>> +++ b/drivers/firmware/qcom_scm.c
> >>>> @@ -1506,8 +1506,7 @@ static int qcom_scm_probe(struct platform_device
> >>>> *pdev)
> >>>>    static void qcom_scm_shutdown(struct platform_device *pdev)
> >>>>    {
> >>>>        /* Clean shutdown, disable download mode to allow normal restart */
> >>>> -    if (download_mode)
> >>>> -        qcom_scm_set_download_mode(false);
> >>>> +    qcom_scm_set_download_mode(false);
> >>>>    }
> >>>>    static const struct of_device_id qcom_scm_dt_match[] = {
