Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EB171F770
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjFBBBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFBBBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:01:10 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2DAE2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:01:07 -0700 (PDT)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 43B1D3F42E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685667665;
        bh=wCbPB1ZDTWLt/oEJv6P7qx4Cdd8dnV7Y9TrZ5aVJ2o0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qf/XcOkaa1ZekfrU8e8pefIvLAuErEBq2vbDuJeLl8UfohcxPbe53BJdfDpOaKIzc
         3qRU+g4B1JsDXDPhbh90sNjTLaj5i+nwDJm1VJ0+HzUKXFjgfLx4nm/ycnHVD8Y4S9
         XRW+jb9MagLpnuaBrpEceiDDB/W319ytSabXGMyavt8guDZF7yTbMlJHvGu4qBbPMt
         1PLRK+TJNUBKBuKyZJA0ZGzT9u71UlUk02E6+Mx9dY3cl6oL745QR+VQCuBdw2U1y2
         0uB+z+iW0Ofu/T04g9FzsTlSeMlpmAjV6F0UFmJ7+ic8AXIyg09xQBN7SomdQu16Zl
         ZURwHdFUk1h+g==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5428d1915acso294653a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685667663; x=1688259663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCbPB1ZDTWLt/oEJv6P7qx4Cdd8dnV7Y9TrZ5aVJ2o0=;
        b=CRP+Ss6Hqik+Ac9YceluNxvj9NiPkN/XAfJfpwHrBNKEu0fAnKZJQ2wgD4LD4fgSTQ
         4VXPzXJwBsHC7pGoIXSyP1ebPYTsxuVy9P2MCM2Kw8xb8Y8kTAEprNuXojcTjeNg5l7F
         32f6farSeV8ZcRbDVeujT6ISN32v5bLPqOUz84RZ337tQPHVGUwKRuhSV2oaEcnNNmZa
         xNHapGcpqcGzuL/5L0bylU8ZUp1W+TFz8QA4LUswYCDUE/ZEyUEh/54YKK05kBiP8ww3
         DlN7q4NrU9BKfdaviqMbAyz/p3CH1fEYzVaksKV14oQuAtM740ENHUNnQBQSsvYl/7UN
         W+vQ==
X-Gm-Message-State: AC+VfDzS05XfhE3j84kq1+FXdaHJh5wSfSpZOJNrVBIBfmTVMqlrQhWx
        4KJgzKAcrcsbVdk+7Q/35at4Fn+mhy0afAeU1g+P47D4ZLuHB7tIKkERUILQd57pCxopqLFGMHA
        72t3v7qEgzadgH8HPspD7yVCl5RWWo4kqnAr0URZjuQehxYlxyJu9jgbOiQ==
X-Received: by 2002:a05:6a20:101a:b0:103:b436:aef7 with SMTP id gs26-20020a056a20101a00b00103b436aef7mr3265573pzc.16.1685667663270;
        Thu, 01 Jun 2023 18:01:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6VYL0KZ+3iS8gCc9F1FccQPyYsJMympHRukppGkxqbJhX/s/Mr1+03VnVxAzE9Sg4EziYgwHd5k/dOBTS9O0k=
X-Received: by 2002:a05:6a20:101a:b0:103:b436:aef7 with SMTP id
 gs26-20020a056a20101a00b00103b436aef7mr3265549pzc.16.1685667662942; Thu, 01
 Jun 2023 18:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230601155652.1157611-1-kai.heng.feng@canonical.com> <164576ab-4e68-ca5d-0c9e-d756588cdbb5@acm.org>
In-Reply-To: <164576ab-4e68-ca5d-0c9e-d756588cdbb5@acm.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 2 Jun 2023 09:00:51 +0800
Message-ID: <CAAd53p6S=nzxgwBky6daJZ8wa-HaBODpjwLPYZ52g8FPXbbACw@mail.gmail.com>
Subject: Re: [PATCH v5] scsi: core: Wait until device is fully resumed before
 doing rescan
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, dlemoal@kernel.org,
        bblock@linux.ibm.com, acelan.kao@canonical.com,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 3:48=E2=80=AFAM Bart Van Assche <bvanassche@acm.org>=
 wrote:
>
> On 6/1/23 08:56, Kai-Heng Feng wrote:
> > During system resuming process, the resuming order is from top to down.
> > Namely, the ATA host is resumed before disks connected to it.
> >
> > When an EH is scheduled while ATA host is resumed and disk device is
> > still suspended, the device_lock hold by scsi_rescan_device() is never
> > released so the dpm_resume() of the disk is blocked forerver, therefore
> > the system can never be resumed back.
> >
> > That's because scsi_attach_vpd() is expecting the disk device is in
> > operational state, as it doesn't work on suspended device.
> >
> > To avoid such deadlock, wait until the scsi device is fully resumed,
> > before continuing the rescan process.
>
> Why doesn't scsi_attach_vpd() support runtime power management? Calling
> scsi_attach_vpd() should result in a call of sdev_runtime_resume(),

It's system-wide resume in this context, so it's dpm_resume() waiting
for the lock to be released by scsi_rescan_device().

Kai-Heng

> isn't it?
>
> Thanks,
>
> Bart.
>
