Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86E2654481
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiLVPnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbiLVPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:43:34 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066BF12AC4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:43:30 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id s9so1615538qtx.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NfRvmfvKFOxDn9g+8R6zgrgTa4YsyN/kNivwQNhwIck=;
        b=AuDhAikVwt0qcXGLmSoHKNsgOvt1MqsjlxCryk6q4Xqs5vo8gMkhKmo9qrrawceIhh
         KjJ7qLocGGKHolGi/3HHf85IgvdqN1WuF0l4pGMMQcPp9gpjUIpfwqIsw8xcKO8zvm53
         KwSduT8LNVo07XCZih7peJLWiKQVbUMO7te4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfRvmfvKFOxDn9g+8R6zgrgTa4YsyN/kNivwQNhwIck=;
        b=lVzT6u8OV9v27CR6csTDPbrlVetKZRzj2NyqRV2N+gR1njU34uZ/WnX8laxPyK81TL
         +bmW6amggdwOIttD746oPPqp287k4Qjlm9mR7naYCbnwRtJqlE5qaV/Tk8OMaq0QEsnh
         Pm68QE6rNTIbqICBlvKAun9IXRBbZlg8U5F8YsYs01OAiaHj7spmGP7PmSFICyKaFo94
         ZVSGiQMTo4siS/Zd8gnkrMFd8/6FKxtix0FWw+7jDhrOsRxnCEVEmBKaW4bd5qUZgdOU
         m3JkKXUMFuJtWrRhOQEtazoMxB1ZP76FJJMivJmhBeFYRhyVEb8Q4tzEENv+rpF3vdNs
         g4jg==
X-Gm-Message-State: AFqh2koEA7TJYenIDQo0zikD/j7tgM7ld4IiTR5cYCX0w1lqU5Xhdk1N
        QskMty260dVKAx0E4qawmRgKKg==
X-Google-Smtp-Source: AMrXdXs70VQHhJgtWr0krmiy2P3ZRJ9SHSqD4QlkkhJj9ABz0PmD7d2sBBbc3F89GZYxo7pRkMj6vw==
X-Received: by 2002:a05:622a:4184:b0:39c:da20:f7e2 with SMTP id cd4-20020a05622a418400b0039cda20f7e2mr6452898qtb.63.1671723810082;
        Thu, 22 Dec 2022 07:43:30 -0800 (PST)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id v22-20020ac87296000000b003972790deb9sm503671qto.84.2022.12.22.07.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:43:29 -0800 (PST)
Date:   Thu, 22 Dec 2022 10:43:28 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: maintainer-pgp-guide: update for latest gnupg
 defaults
Message-ID: <20221222154328.lort3wvixcyykeyx@nitro.local>
References: <20221220-docs-pgp-guide-v1-1-9b0c0bf974fb@linuxfoundation.org>
 <Y6RVTQxhcxDDrvO3@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6RVTQxhcxDDrvO3@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 08:02:05PM +0700, Bagas Sanjaya wrote:
> Shouldn't "Protecting Code Integrity" doc also be updated with recent
> situation?

Yes, I'm working on updating that document as well. By the time this change
makes it into mainline, both documents will be a close match.

> LGTM, thanks.
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks!

-K
