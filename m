Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02A570B994
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjEVKEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjEVKEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:04:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115EBB9;
        Mon, 22 May 2023 03:04:35 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae58e4b295so36723225ad.2;
        Mon, 22 May 2023 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684749874; x=1687341874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jhVwvH6aZyGY/Qs54+Mq5wpe5VqNH8kEeeph22J9Qrg=;
        b=WSnW01H4GQxRwcdfysdcKrlHiim7FXa7Db+vRex58HvWpNsKcv995LdtgS6zknjBoX
         /hzh58emjQRYuanAPgdipw3Dmx22Zgc0HqtPrWHlOoBnrQZnAufh2Tmoy5lRpBi5mdsR
         jsLyX0lwNFUIx+yklZAvPW7kEOVVReqFRKibEW9K4T4nQ7rouUPvhsvlO9VYVf8ZxfHm
         EkR/+/euyja4Zo2dSe+nwVDiv6TXGiRadfMvJsR40h36MkMxZteWBSVyenm2k3UBeOJA
         Cuv4vGx+TzmhU62k8CrskKqR2tNjnwhDNZiB8b+oFSQakjYlDmYopZ4UKDIQSFqEpJjp
         GpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684749874; x=1687341874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhVwvH6aZyGY/Qs54+Mq5wpe5VqNH8kEeeph22J9Qrg=;
        b=TYmNFzST1hVq1qA3XrU2K2f3oHgynr3WvKcERc5me109OjFlq7Zc0yIL2cwSwoahCo
         zCRvVcJtRhATqOzYcmNqSZcrKUkqNYHTTupoHy0yxQFJRVeuQ8EsPsFDqMXyHemdE4XW
         PgJTtBcP1ZiyzJDrA9rl9luZBrDv8njHZqLY2I+EDkYJXcgvKWokxZ+6V3/Yfl3nt59E
         PxLPO7f6wnO6XII6tDvtjcnsXGljNqSvJQQyrStrhLCYPJ3vVGHOtQzJ7cq+8Jw5Pr6Z
         XURIn2oWmksoC/VyjZGRrPJWVSJI/8k3JpjskoDBHzqwoaK5BCplccsOXTzu2tpXwch8
         QB+A==
X-Gm-Message-State: AC+VfDz/nAkV7PXXW3R/6Rt4Fn8QuYCTCi1BJy9ubteXb9r2RkG9BXmL
        vjP4W9ASBm/B48GsDZpaE2S1Am7P9aY/iAiR5YI=
X-Google-Smtp-Source: ACHHUZ5dGebJk/KHdgcZz4oStApY8Yia2D8B3dB0BXMMtCLIxr8Tp1tKEosTO/U7D91J/w7z8S2QGLZ3ivambahLqL8=
X-Received: by 2002:a17:902:b410:b0:1a9:7ffb:5ed0 with SMTP id
 x16-20020a170902b41000b001a97ffb5ed0mr8701045plr.59.1684749874454; Mon, 22
 May 2023 03:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <1678979666-551-1-git-send-email-quic_mojha@quicinc.com>
 <76943268-3982-deaf-9736-429dd51e01b0@gmail.com> <0e645486-f0be-4468-18ad-9e49088dee0b@quicinc.com>
 <CAOX2RU4xPNq4-OHUoMZtfZu05QEdpk1UtawZb1xQMrtc5ao84Q@mail.gmail.com>
 <a6c48095-179a-7e72-a282-fbc28af374cb@quicinc.com> <CAOX2RU6S-x-KrQ-qQLW-qxu4bph79d+Yq9Vj=PQwWW4o-yG2xA@mail.gmail.com>
In-Reply-To: <CAOX2RU6S-x-KrQ-qQLW-qxu4bph79d+Yq9Vj=PQwWW4o-yG2xA@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 22 May 2023 12:04:23 +0200
Message-ID: <CAOX2RU6rv0jcnTRAa=kiWHPk1A=DW=smS72df_t+tufOZ9XGfA@mail.gmail.com>
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

On Mon, 22 May 2023 at 11:26, Robert Marko <robimarko@gmail.com> wrote:
>
> On Mon, 22 May 2023 at 11:11, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> >
> >
> >
> > On 5/22/2023 2:29 PM, Robert Marko wrote:
> > > On Mon, 22 May 2023 at 08:11, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> > >>
> > >>
> > >>
> > >> On 5/18/2023 3:45 PM, Robert Marko wrote:
> > >>>
> > >>> On 16. 03. 2023. 16:14, Mukesh Ojha wrote:
> > >>>> During normal restart of a system download bit should
> > >>>> be cleared irrespective of whether download mode is
> > >>>> set or not.
> > >>>>
> > >>>> Fixes: 8c1b7dc9ba22 ("firmware: qcom: scm: Expose download-mode control")
> > >>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > >>>
> > >>> Hi, this has been backported to 5.15.111, however it seems to be
> > >>> breaking reboot
> > >>> on IPQ4019 by causing the board to then hang in SBL with:
> > >>> root@OpenWrt:/# reboot
> > >>> root@OpenWrt:/# [   76.473541] device lan1 left promiscuous mode
> > >>> [   76.474204] br-lan: port 1(lan1) entered disabled state
> > >>> [   76.527975] device lan2 left promiscuous mode
> > >>> [   76.530301] br-lan: port 2(lan2) entered disabled state
> > >>> [   76.579376] device lan3 left promiscuous mode
> > >>> [   76.581698] br-lan: port 3(lan3) entered disabled state
> > >>> [   76.638434] device lan4 left promiscuous mode
> > >>> [   76.638777] br-lan: port 4(lan4) entered disabled state
> > >>> [   76.978489] qca8k-ipq4019 c000000.switch wan: Link is Down
> > >>> [   76.978883] device eth0 left promiscuous mode
> > >>> [   76.987077] ipqess-edma c080000.ethernet eth0: Link is Down
> > >>> [
> > >>> Format: Log Type - Time(microsec) - Message - Optional Info
> > >>> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> > >>> S - QC_IMAGE_VERSION_STRING=BOOT.BF.3.1.1-00123
> > >>> S - IMAGE_VARIANT_STRING=DAABANAZA
> > >>> S - OEM_IMAGE_VERSION_STRING=CRM
> > >>> S - Boot Config, 0x00000021
> > >>> S - Reset status Config, 0x00000010
> > >>> S - Core 0 Frequency, 0 MHz
> > >>> B -       261 - PBL, Start
> > >>> B -      1339 - bootable_media_detect_entry, Start
> > >>> B -      1679 - bootable_media_detect_success, Start
> > >>> B -      1693 - elf_loader_entry, Start
> > >>> B -      5076 - auth_hash_seg_entry, Start
> > >>> B -      7223 - auth_hash_seg_exit, Start
> > >>> B -    578349 - elf_segs_hash_verify_entry, Start
> > >>> B -    696356 - PBL, End
> > >>> B -    696380 - SBL1, Start
> > >>> B -    787236 - pm_device_init, Start
> > >>> D -         7 - pm_device_init, Delta
> > >>> B -    788701 - boot_flash_init, Start
> > >>> D -     52782 - boot_flash_init, Delta
> > >>> B -    845625 - boot_config_data_table_init, Start
> > >>> D -      3836 - boot_config_data_table_init, Delta - (419 Bytes)
> > >>> B -    852841 - clock_init, Start
> > >>> D -      7566 - clock_init, Delta
> > >>> B -    864883 - CDT version:2,Platform ID:9,Major ID:0,Minor
> > >>> ID:0,Subtype:64
> > >>> B -    868413 - sbl1_ddr_set_params, Start
> > >>> B -    873402 - cpr_init, Start
> > >>> D -         2 - cpr_init, Delta
> > >>> B -    877842 - Pre_DDR_clock_init, Start
> > >>> D -         4 - Pre_DDR_clock_init, Delta
> > >>> D -     13234 - sbl1_ddr_set_params, Delta
> > >>> B -    891155 - pm_driver_init, Start
> > >>> D -         2 - pm_driver_init, Delta
> > >>> B -    909105 - Image Load, Start
> > >>> B -   1030210 - Boot error ocuured!. Error code: 303d
> > >>>
> > >>> Reverting the commit fixes rebooting.
> > >>
> > >> Hi Robert,
> > >>
> > >> Can you check if disable SDI [1] works with this issue
> > >>
> > >> https://lore.kernel.org/linux-arm-msm/20230518140224.2248782-1-robimarko@gmail.com/
> > >>
> > >> [1]
> > >>
> > >>
> > >> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > >> index fde33acd46b7..01496ceb7136 100644
> > >> --- a/drivers/firmware/qcom_scm.c
> > >> +++ b/drivers/firmware/qcom_scm.c
> > >> @@ -1508,6 +1508,7 @@ static int qcom_scm_probe(struct platform_device
> > >> *pdev)
> > >>    static void qcom_scm_shutdown(struct platform_device *pdev)
> > >>    {
> > >>           /* Clean shutdown, disable download mode to allow normal restart */
> > >> +       qcom_scm_disable_sdi();
> > >>           qcom_scm_set_download_mode(false);
> > >>    }
> > >
> > > Hi,
> > > I can confirm reboot works this way as well.
> >
> > That's great, So, i don't need to revert the patch and you can
> > add this in your patch without target specific check ?
>
> Oh, you mean IPQ4019 not rebooting?
> I haven't tested that, give me couple of minutes to try that out.
> Cause, the link was just back to the SDI patchset.

And, I can confirm that IPQ4019 does not reboot even with SDI disabled if dload
mode was set so it still needs a revert.

Regards,
Robert
>
> Regards,
> Robert
> >
> > -- Mukesh
> >
> > >
> > > Regards,
> > > Robert
> > >>
> > >>
> > >> -- Mukesh
> > >>
> > >>>
> > >>> Regards,
> > >>> Robert
> > >>>
> > >>>> ---
> > >>>> Changes in v3:
> > >>>>     - Added Fixes tag.
> > >>>>     - Removed it from below patch series, as it makes sense to go this
> > >>>> independently.
> > >>>>
> > >>>> https://lore.kernel.org/lkml/1677664555-30191-1-git-send-email-quic_mojha@quicinc.com/
> > >>>>
> > >>>> Changes in v2:
> > >>>>     - No change.
> > >>>>
> > >>>>    drivers/firmware/qcom_scm.c | 3 +--
> > >>>>    1 file changed, 1 insertion(+), 2 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > >>>> index 468d4d5..3e020d1 100644
> > >>>> --- a/drivers/firmware/qcom_scm.c
> > >>>> +++ b/drivers/firmware/qcom_scm.c
> > >>>> @@ -1506,8 +1506,7 @@ static int qcom_scm_probe(struct platform_device
> > >>>> *pdev)
> > >>>>    static void qcom_scm_shutdown(struct platform_device *pdev)
> > >>>>    {
> > >>>>        /* Clean shutdown, disable download mode to allow normal restart */
> > >>>> -    if (download_mode)
> > >>>> -        qcom_scm_set_download_mode(false);
> > >>>> +    qcom_scm_set_download_mode(false);
> > >>>>    }
> > >>>>    static const struct of_device_id qcom_scm_dt_match[] = {
