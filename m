Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6589A5FEC69
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 12:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJNKPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 06:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiJNKPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 06:15:49 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8613814D8CB;
        Fri, 14 Oct 2022 03:15:46 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id w185so2028495vkb.7;
        Fri, 14 Oct 2022 03:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+gKmpXKgt1tAoH04/NabLDpfsbAN80C2OC0RyjXBWk=;
        b=MXnxk1uqshMOeR+5b0Qh5CEwJSTgTL7gpkXjyIXGG2GatnTYBTtOHxIAGFOF9BAyUG
         qv6gRE0JJhCb0pcOfEIOKeDGIqRrlKLZGKkNeROXWOX+WRlFTssrPWia+3dOUmhWouT5
         82Iei2Y8tuLe+5s6/fsTJ3jxH524aZA4bALwyM7wiT+ULEH/9Bh31VLjl8UUe+W8peUp
         IjdnS5g8OJSaNv+QYfJfpuOFQqg7ElQydxmhl/9hLun/POwexJANXh0H7egTc3T8jve1
         cE8y9bmTRzFcRC1u0Bh4sF7CNcFznTqY5Z7IDdPGBltSSPdjvORmuIYxOU0kfEwEukwQ
         1WJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+gKmpXKgt1tAoH04/NabLDpfsbAN80C2OC0RyjXBWk=;
        b=AvxETRs8AJ1euVPyEnD3fivp2czw2qxWVrj0syRvY/0sCv6hQ3f0rRe0p833CfJROH
         O047/r5dP0GhxpR7FlwiQ76o9XfypdEhvT6IACwuwio0UwmMfREb4hV5weY/QwEHjvgG
         SDVtDXCrFCdzcpDYJYF8Qy4BkJFB5Xq7uAi9tK3enZNe/naPJ0ygsYQcvrZ0N6mi7vQt
         SX479XpIURkiixZOGJ60aAhPcnhYkJksbRhh2L9C0XvYTr7f/MM7vV9J3itlSXIgU9Jr
         iZaqx0CF4nehhOVuKVZHoFePWjbBJPcqISGCSgzRGaP+UnYGlT8n2LcR2xCIR6ni6Eas
         gbTA==
X-Gm-Message-State: ACrzQf16cD1TvfzlVqdFBIn8R/o56n8S/ZJzz3wfnsudSgb/g8cfAkIJ
        TPFnLQJ9YTeVvPQdAE7z9RTMrSnXlY8gr09AGWU=
X-Google-Smtp-Source: AMsMyM5OsuGqEt00rFFB5lGPzbqrqaJ3JJZl18t15Cr7HId5BiaURpyJvjxJSe0GkOoQygd+8LinZ5wVDlCJhuq+GUc=
X-Received: by 2002:a1f:9bd0:0:b0:3af:163a:72f9 with SMTP id
 d199-20020a1f9bd0000000b003af163a72f9mr2354444vke.0.1665742545064; Fri, 14
 Oct 2022 03:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221011021653.27277-1-gaoyankaigeren@gmail.com>
 <DM6PR04MB6575AE77585D584652179089FC239@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAFN68yVajOkV++gCp-y1+SD5VOKLgUeBhfgskrJZOX5dfGi07A@mail.gmail.com>
 <bee1807b7d072b221c44ac8c2ed8064939d33696.camel@gmail.com>
 <CAFN68yVdwrECaDvNuok_4V-54UZUJU9+dn5icaiPdj6BXEZuVA@mail.gmail.com> <8678f69aa94003b357c4c8ef42cd6ce5c7487f8d.camel@gmail.com>
In-Reply-To: <8678f69aa94003b357c4c8ef42cd6ce5c7487f8d.camel@gmail.com>
From:   =?UTF-8?B?6auY5Lil5Yev?= <gaoyankaigeren@gmail.com>
Date:   Fri, 14 Oct 2022 18:15:33 +0800
Message-ID: <CAFN68yUKXquOLqL_6oBRjfDGDT=NgQPF3cpo7bkHyJ1gNTDbZA@mail.gmail.com>
Subject: Re: [PATCH] ufs: core: Disable auto h8 before ssu
To:     Bean Huo <huobean@gmail.com>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Bean
Yes, This is the time from when the system enters idle to when auto h8
is issued.
This patch is just to ensure that there is no continuous action of
"auto h8 exit" before dme h8 enter, it has nothing to do with idle
time.
The reason I want to ensure this order is because when there is an
action of "auto h8 exit", most devices take a certain amount of time
to get the state ready.
Immediately after the action of "auto h8 exit" is completed and "dme
h8 enter" is followed, the device will be abnormal.
And I think it's more of a common patch for all platforms, Patch can
adapt different vendors,and align to ufshcd_auto_hibern8_enable in
__ufshcd_wl_resume.

Bean Huo <huobean@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=BA=94 13:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 2022-10-14 at 10:44 +0800, =E9=AB=98=E4=B8=A5=E5=87=AF wrote:
> > " UFSHCI has idle time before bringing Link into hibern8 mode, " I
> > think  ufs put the link to h8 during the time
>
>
> no,  it is ufs controller. see the ufshci spec:
>
> "Auto-Hibern8 Idle Timer Value (AH8ITV): This is the timer that UFS
> subsystem must be idle before UFS host *controller* may put UniPro link
> into Hibernate state autonomously. The idle timer value is multiplied
> by the indicated timer scale to yield an absolute timer value. ....
>
> ...
> Any non-zero value will enable Auto-Hibernate idle timer.
> UFS host controller shall put Unipro link out of Hibernate state when
> the link communication is required. The mechanism to decide when the
> Unipro link needs to become active is host controller specific
> implementation, and is transparent to the software."
>
>
