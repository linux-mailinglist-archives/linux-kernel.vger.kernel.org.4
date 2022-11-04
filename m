Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060BE619DD1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiKDQwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiKDQwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:52:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B61C4385B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:51:03 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so3556791wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n5QQmhQYlJu0g2umyiifZ4v1v3v8ZYJYFgjE0g6FoAY=;
        b=rUbLXeIFiV1fE+KkSF+NNFtUDmdRlf+e2dnUwLxx3HRGbCsN6iZ9G+KTZ+fWGHDib+
         tpt3mDHxng4PdFQKfDMDyiJmePvhRPYubZorRkJ76enaucZM5gvrS2R3p53djwQ79O84
         XaUvG1j5lAfHMzkAp57pTZ6T4TT1VavyCWBCrHyq+/ociUS3v2v24EDVfd+sEBjM8jQz
         sEXfAE9zuLNuhCYgYKzNj6c+n5KsxBLtys1A6scVOombAuFDmqpQWAoB6W0VWEPABGHy
         Yh9DEoZcMLDJwrSgVm6Ev+2T7LkHFGeHTsrSvVK8WXiI5h0cWPxcllpkRlestVEZzofg
         AG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5QQmhQYlJu0g2umyiifZ4v1v3v8ZYJYFgjE0g6FoAY=;
        b=poP44pTIygTZZlTqF2jjWPQRfm0EeKseYaIW9gEbHIoI+OdEkqOuRu8TUsuPbh1IsT
         YbHdBPwGDLpzJZgYjeVAk+4UaL6firFmNwrC/DTeNi67sUlkeAFN76wPGxC+Kznd6v8t
         wUaPO7DTwtGkmHqzRkOltPPSTG5AJMjMgpbM+tjmjR6umZ7Ft3ZEpmaNqkGxI4lUzV7k
         UNGviVFNXkPJjMd6DLfBdM4olbOaqkWlBnTGMSDdFfh5cCM/URzMWzoyMwZkTADMM+HP
         1amXhAzbZDw3khMIwllNDd3TgO6BMBAha1yQ+6PjQ9rgRr2Kx/R+77H/ddn7ng85Srvd
         91yQ==
X-Gm-Message-State: ACrzQf3rAPLUAgi5bqIgSIZTLQrCQNUknPeKoKsxxXZjbvo+apS/oYcF
        Cj9BuFi09PwgPVa1AJlJ9hpXOkvqJNlCpTv5IbV/I9WzRPc=
X-Google-Smtp-Source: AMsMyM4MEEygxd1XMsEwfrtmGiBglppHD5QjOlUnlWY6ACQHuoCoSbvgD8iql9iMzp+BrErm6vjZ23Z2HoiGs7aXJwU=
X-Received: by 2002:a1c:f214:0:b0:3be:4e7c:1717 with SMTP id
 s20-20020a1cf214000000b003be4e7c1717mr24943418wmc.171.1667580661874; Fri, 04
 Nov 2022 09:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210913233435.24585-1-pcc@google.com> <CAMn1gO6zzSWJktCeH9Tg=eqpTR5innBOgqVOeDvBV0hcDi-uog@mail.gmail.com>
In-Reply-To: <CAMn1gO6zzSWJktCeH9Tg=eqpTR5innBOgqVOeDvBV0hcDi-uog@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 4 Nov 2022 09:50:50 -0700
Message-ID: <CAMn1gO5GVVrbMp_s0FPBwQWo0vEw9JpGUoLtBg5dWCVkEtquYw@mail.gmail.com>
Subject: Re: [PATCH] get_maintainer.pl: support running from non-top-level dir
To:     Joe Perches <joe@perches.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 2:31 PM Peter Collingbourne <pcc@google.com> wrote:
>
> On Mon, Sep 13, 2021 at 4:34 PM Peter Collingbourne <pcc@google.com> wrote:
> >
> > My workflow usually involves running scripts from a subdirectory of the
> > kernel source tree. This fails with get_maintainer.pl because it assumes
> > that it runs from the top level. Fix this assumption by setting $lk_path
> > appropriately based on a check of $0 similar to what is in checkpatch.pl.
> >
> > This also requires fixing the VCS available checks to also check $lk_path.
>
> Ping.

Ping^2.

Peter
