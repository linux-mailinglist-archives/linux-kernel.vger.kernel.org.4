Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468E063D4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiK3LwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbiK3LwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:52:01 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B493FB98
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:52:00 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s196so15815226pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dNNjhgV3S5RdpENCw0tftaakTT+Yexade7uuOVbpd6o=;
        b=MlE+4d00P4MS06c4jDotbUsQa2Y4YNQIckfJ0z14AHQeZnxqczsfygFGylW51qBSpd
         nIf6LEX/78C2/tD5AVedQAquVk27LWwDDlK7+Usez7Yw5ooF3/3B45eL8yhifTu7HJSn
         2duINRhix7wbvWUvb/yxkcvHf+WCuB6GOB4QNb1cQMSgORmtxkDZ8sgA9IEcGk5szeKN
         YXtvYSfy+HFYE+1HWt6fXiz8GiAgAj3nFSAWeXz8tiisPEb+ZuAB//RP/8uyOB9+ByJP
         k1NonLspXFclKmsYLb/wdeZjBoHtL1kjbg2SxCx30No2Vho928wwFlkCcMcb/duXK/Z4
         owAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNNjhgV3S5RdpENCw0tftaakTT+Yexade7uuOVbpd6o=;
        b=xiuiVQb8N3HKyRoni03PNgvQux6TG66wlrEa1t3VhMiaEmDd2m1hycjXpfwCFG0qgu
         6BST7zwrFuHTxi821N1bLFF2Om5wILes9PaWq/vhP+u5SiBl6Sulp8mbNWoGcI/18DmJ
         v/9FER5xziVGI2wogRFLBoDH7mIDKRMCZkTgCUwyEoXzuS8H4YyCDqiUQc14Y3lpJzZq
         AvRkkC/cTLQi4KRA664r9CJRSybaO8wmA3MlfnJgIGX/Mt1lA4UNuHG5nRZA/T+YjTv/
         RxiK0KfyhcOILIOI6cKGKz4aQldggw6Pz9s24N3msJORWR3sXtI60d9RtTZn8BPlwOCW
         xQgA==
X-Gm-Message-State: ANoB5plHvtpFYPgjsO4qEuqJY2iawGaDhxJ/mUL7bEhsggmJgvdmv/04
        OIroBc2av8AMD1Dqq012CMpwboNxynDclJLGESAd1LvzKs0=
X-Google-Smtp-Source: AA0mqf4V3FbSvEBCUTUXOM1lRoKxD98ykmkeLYKEP1Y/KSzfaSkTKFlhubIDY6fgbHz0Oi57SLprqUXk/DwrBDW+sZE=
X-Received: by 2002:aa7:87da:0:b0:575:2f34:29d4 with SMTP id
 i26-20020aa787da000000b005752f3429d4mr14660026pfo.40.1669809119534; Wed, 30
 Nov 2022 03:51:59 -0800 (PST)
MIME-Version: 1.0
References: <20221130092847.2092-1-thunder.leizhen@huawei.com>
 <CAPDyKFphNdR-TorULpbsMtM6MzqsaK_UdSmG9Hin=wunUwJwJQ@mail.gmail.com>
 <d9d44a9c-e61e-2803-731b-cfa5f3d3d46c@huawei.com> <CAPDyKFrbRcEgtwbgBY8bsDW3YTtXJBS0zRhJq-Emf89hDWaUjg@mail.gmail.com>
 <fa77b721-387c-5de9-e8a8-7a55bd568372@huawei.com>
In-Reply-To: <fa77b721-387c-5de9-e8a8-7a55bd568372@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Nov 2022 12:51:23 +0100
Message-ID: <CAPDyKFowUCYOB16jYx6qqc3kbuqEAjVUXexTSn11KiZ71twZ+A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix error return code in sd_read_ext_regs()
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 at 12:45, Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2022/11/30 19:33, Ulf Hansson wrote:
> > On Wed, 30 Nov 2022 at 12:18, Leizhen (ThunderTown)
> > <thunder.leizhen@huawei.com> wrote:
> >>
> >>
> >>
> >> On 2022/11/30 18:04, Ulf Hansson wrote:
> >>> On Wed, 30 Nov 2022 at 10:29, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >>>>
> >>>> Fix to return a negative error code from the error handling
> >>>> case instead of 0, as done elsewhere in this function.
> >>>>
> >>>> Fixes: c784f92769ae ("mmc: core: Read the SD function extension registers for power management")
> >>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>>> ---
> >>>>  drivers/mmc/core/sd.c | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> >>>> index 3662bf5320ce56d..7b64f76f0179ca8 100644
> >>>> --- a/drivers/mmc/core/sd.c
> >>>> +++ b/drivers/mmc/core/sd.c
> >>>> @@ -1277,6 +1277,7 @@ static int sd_read_ext_regs(struct mmc_card *card)
> >>>>         if (rev != 0 || len > 512) {
> >>>>                 pr_warn("%s: non-supported SD ext reg layout\n",
> >>>>                         mmc_hostname(card->host));
> >>>> +               err = -EOPNOTSUPP;
> >>>
> >>> The original intent was to not return an error code. Simply, because
> >>> the card remains functional and all but the new features from the SD
> >>> function extensions registers can still be used.
> >>
> >> OK, I got it.
> >>
> >>>
> >>> Perhaps, we should update the comment a few lines above to better
> >>> reflect that this is in-fact what we intend here.
> >>
> >> How about also add 'warning' to the output? The other two outputs
> >> contain the 'error' keyword.
> >
> > There is already a pr_warn(), or is there something you want to add to that?
>
> No, I don't have anything else to add.
>
> I just saw the other two error outputs are also use pr_warn(). Maybe they
> need to be changed to pr_err().

Aha, that's a good point! We should change those to pr_err().

Kind regards
Uffe
