Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ED85E5BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiIVGv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIVGv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4E4B2DA8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663829514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m9dathN3dA6k+TEdInmB8gMxW6TSqHdaE9ym8yw3kwI=;
        b=QDec6F6WkHTO3mV8n2tH+I5LD8jhmCoBn7ASStNcTpFs3vJ5+O43yBnr4/dtEloDDsk47D
        1yANuUOk/4lvpJfgfGb8bEseqNNFJObXET7+n/lTogblts2+3VevjDMFncO00El8Kyvp9f
        GktC8jr1M5cyaRNvO3lg2MyACXj+6IE=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-481-udNnry9ePNepHc67GKvLRQ-1; Thu, 22 Sep 2022 02:51:52 -0400
X-MC-Unique: udNnry9ePNepHc67GKvLRQ-1
Received: by mail-io1-f71.google.com with SMTP id x22-20020a6bda16000000b006a123cb02beso4150090iob.18
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=m9dathN3dA6k+TEdInmB8gMxW6TSqHdaE9ym8yw3kwI=;
        b=V/ePXczujVkLRFnsrRjpM2NKisSitiA9LwXg30uuufDcFR2hNQc4og3fSA7t7s470b
         SnYjYQhN+R7KFG1Buy5q7g0dLb6/k5HqMepoxR/9TxhuEWJaPGhggTgvUes9bhpdv/sd
         Nj/oMXpw3EstjfzVGhpECq8dpqiEevTOc3JOCfRc/Ozj27Xcj5378pt/04nLPOSwDxKc
         jdRJUEy/OOhzYIvGAtx0vHQkT/emDPycdOJQ54WtJdF8ThHlSC9GyNYKrl/9jHLN9xUR
         d1ExPpQ+AHmrmDlFGWhaCgCUwDQW7ck24od62ykyyznLi/zcCrTrtMRXtSQb2MhJdRsk
         wUug==
X-Gm-Message-State: ACrzQf0PEzeqsHgxUh77lTrRf52Kf4AcOqR7zCVQmYlB8uiA91kv5Cwm
        baA8MDxnoP3/JyseVu6wmY9lxRcq85knWmRM7uyckeBL8X9KtIy72F71UoS09+1wZt5FL9POCRI
        RZjvPj02cORuPLEbcAmYL+voJV6JSLyfv98YhrknA
X-Received: by 2002:a05:6602:1592:b0:6a2:1feb:4809 with SMTP id e18-20020a056602159200b006a21feb4809mr904270iow.214.1663829512327;
        Wed, 21 Sep 2022 23:51:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7+fHWI4kFLUkkQDcyVGoWabvyt2XrxpQfnE2BrPozOLpWfWtGlXXXV698qbPgkNLwTQONyiBP9yfLGU7D2LVU=
X-Received: by 2002:a05:6602:1592:b0:6a2:1feb:4809 with SMTP id
 e18-20020a056602159200b006a21feb4809mr904265iow.214.1663829512167; Wed, 21
 Sep 2022 23:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <1660559178-5323-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
 <20220921151143.xrchxekzqrgqlujv@mail.corp.redhat.com> <YyuVbPOt3Iul7s/Y@google.com>
In-Reply-To: <YyuVbPOt3Iul7s/Y@google.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 22 Sep 2022 08:51:41 +0200
Message-ID: <CAO-hwJLV7YNMkVJc4kh-Md3fKiVpgsfOo41qfLoZvofkoBXgBg@mail.gmail.com>
Subject: Re: [PATCH V4] HID: HID-rmi - ignore to rmi_hid_read_block after
 system resumes.
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     margeyang <marge.yang@synaptics.corp-partner.google.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Hans De Goede <hdegoede@redhat.com>, dancarpenter@oracle.com,
        marge.yang@tw.synaptics.com, derek.cheng@tw.synaptics.com,
        vincent.huang@tw.synaptics.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 12:51 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Benjamin,
>
> On Wed, Sep 21, 2022 at 05:11:43PM +0200, Benjamin Tissoires wrote:
> > On Aug 15 2022, margeyang wrote:
> > > From: Marge Yang <marge.yang@synaptics.corp-partner.google.com>
> > >
> > > The interrupt GPIO will be pulled down once
> > > after RMI driver reads this command(Report ID:0x0A).
> > > It will cause "Dark resume test fail" for chromebook device.
> > > Hence, TP driver will ignore rmi_hid_read_block function once
> > > after system resumes.
> > >
> > > Signed-off-by: Marge Yang<marge.yang@synaptics.corp-partner.google.com>
> > > ---
> >
> > I have fixed your signed-off-by line by adding a space between your name
> > and address, and converted the C++ style comments into proper multiline
> > comments, and applied to for-6.1/rmi in hid.git
> >
> > Sorry for the delay, this one went through the cracks.
>
> I think we are rushing with this. There are questions whether the ACPI
> data for the device is generated properly and also whether we should be
> smarted when counting wakeup events in case interrupt that is
> potentially wakeup-capable  happens in the middle of the resume process.
>
> The patch is not a fix for behavior that affects users, but rather a
> band-aid to appease a Chrome OS test, which is IMO is a weak reason for
> accepting the patch.

All right, fair enough.

I'll drop it from the for-6.1/rmi branch and for-next then. I thought
Marge's explanations in v3 were convincing enough but I don't have
visibility on the ChromeOS bugs.

Cheers,
Benjamin

