Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB7F715CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjE3LT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjE3LT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:19:26 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390B8EC;
        Tue, 30 May 2023 04:19:25 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-6262be06e2eso6833296d6.1;
        Tue, 30 May 2023 04:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685445564; x=1688037564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JcaGk53DfoljsKEc0Vqh4/+1ZEOZS900niaaCgJ++s=;
        b=C2wDD805ebGsBV7b0K81S5Eb8pSn0DdvY2plhQ2gb9qX9Yc7JMgWFs16+iG8k/PL7d
         Vh/G674aaMIecEd3AsU84A9PZcegaZiYkUvaOPXzGWz86nGsaE2MdYq2fTBWcpfJ6+0c
         u9ZBexHLihF2fVBIfwb8eYxzRM2sZgPSBcCeNASGxO0CBKjpGu1owbw7G3ZDuxQoYCKh
         q0Mna3NfUGyNzTuPtoUnsXvzvLH/2PfPj+NfwjTD3vxmin6ybiA43QNaW8kVxJAiE/pa
         h8TxQs3NRqxvWg+s48i59MqnlRuUnd3GxL8Gw11vw/bMS0gTFI1XQ+6JeJxWyJ1zhcnB
         wJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685445564; x=1688037564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JcaGk53DfoljsKEc0Vqh4/+1ZEOZS900niaaCgJ++s=;
        b=XW7n3NzvFdUZcC7i3Q1eyOGhZORnk5SbvRFfcpXRGqkHbUc25ApiH8hxbHiF3D29oA
         I5a7RiU6eUxSNz0zgHnvOWUxskbVdCcaEwAW1b0eVG8oCw2tSMlNMKE1PJaivv8sFZB/
         X1VLt2kCvBdAqjlDPTAtvYebSeuYW/207W6NBg6Ps15grvglIVtDpJqvs51NAKbjZpIp
         FVDUWluVMOlZcRhn0EH/wUEyH8yGqrDkK1JItK3mBk1EvRnaG81pIMy7QZQSuj5wJZnL
         moUFdjfHNelKM2I/SyM+pyVSr63AOYLD4Ddm/JrQpJi77LgIn7VPooWInD2fbSrVvImj
         8B8w==
X-Gm-Message-State: AC+VfDyqPz5+s6+VDWOwwQiyxDEnh7k4WS0FaNPDDCDUnQzsXHDiEaBR
        7+daQz2QOMuSfo2fv66hksjWyhVRYdZ/IlELCHc=
X-Google-Smtp-Source: ACHHUZ5DBOUiWsRXCdlSENWFz5Kmv7KFin+OkFZ+1MD7nnexfUJEN1pyBDQ9HHsusXK2WSP6vMn4DZZaMjG9/b5DC9E=
X-Received: by 2002:a05:6214:2627:b0:623:c96a:e735 with SMTP id
 gv7-20020a056214262700b00623c96ae735mr1861312qvb.1.1685445563839; Tue, 30 May
 2023 04:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230524160352.19704-1-osmtendev@gmail.com> <87v8gajeni.fsf@kernel.org>
 <CAK6rUAPUKNREyYL-d5Y23SOV__-zPY8KJL+MMzWX8ShOhDGWLA@mail.gmail.com>
In-Reply-To: <CAK6rUAPUKNREyYL-d5Y23SOV__-zPY8KJL+MMzWX8ShOhDGWLA@mail.gmail.com>
From:   Osama Muhammad <osmtendev@gmail.com>
Date:   Tue, 30 May 2023 16:19:13 +0500
Message-ID: <CAK6rUANkoGLAMSQjy5Wrav02u10MKxK8ov1Xekq-goMNu0Tcug@mail.gmail.com>
Subject: Re: [PATCH] debugfs.c: Fix error checking for debugfs_create_dir
To:     Kalle Valo <kvalo@kernel.org>
Cc:     nbd@nbd.name, ryder.lee@mediatek.com, lorenzo@kernel.org,
        shayne.chen@mediatek.com, davem@davemloft.net,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the previous email mistakenly I have referenced debugfs_create_file
but it's the same for debugfs_create_dir also.

Here is the link to comment above the function debugfs_create_dir
https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L564

Thanks,
Osmten

On Tue, 30 May 2023 at 16:02, Osama Muhammad <osmtendev@gmail.com> wrote:
>
> Hi,
>
> I will keep that in mind and send with the right subject while
> submitting a revision of the patch.
>
> Regarding the patch after researching more into it I have come to know
> that the debugfs
> API will not return null on error but an ERR_PTR. The modern wisdom
> about it is to ignore the errors returned by the function as stated in
> the comment  above the function debugfs_create_file.
>
> > * NOTE: it's expected that most callers should _ignore_ the errors returned
>  >* by this function. Other debugfs functions handle the fact that the "dentry"
>  >* passed to them could be an error and they don't crash in that case.
> > * Drivers should generally work fine even if debugfs fails to init anyway.
> Here is the link to comment :-
> https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L451
>
> Considering this, I will send the revision of the patch by removing
> error checks. Please correct me if  there are any concerns with this.
>
> Thanks,
> Osmten
>
> On Tue, 30 May 2023 at 15:29, Kalle Valo <kvalo@kernel.org> wrote:
> >
> > Osama Muhammad <osmtendev@gmail.com> writes:
> >
> > > This patch fixes the error checking in debugfs.c in
> > > debugfs_create_dir. The correct way to check if an error occurred
> > > is using 'IS_ERR' inline function.
> > >
> > > Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> >
> > The title is wrong, please see the wiki page below how to create titles.
> >
> > Also no need to say "This patch fixes..", saying "Fix..." is enough.
> >
> > --
> > https://patchwork.kernel.org/project/linux-wireless/list/
> >
> > https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
