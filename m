Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7755FE154
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiJMSe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiJMSd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:33:58 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0188C5892
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:30:27 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id f22so2253812qto.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j+0Vad9BFbF32UPRLC61bpkOrYfkjxAqBsb66I31Wec=;
        b=BJdZnZLF+UmEbgAXLJaKi1dcnDWnlyL8dx4IkaVpS4ke3AnJG19c2Az4E4gsIr6i5W
         Owekm0O6buzWHEGHOo72ZMP4qnyDqwFFJiEXsynw3dTB+rEQFXRqg85n8Z8n/eoHJUKE
         FAWtRkCz+dmlqoD69LAY8MPc3svMV9e9xLNkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+0Vad9BFbF32UPRLC61bpkOrYfkjxAqBsb66I31Wec=;
        b=d9y46yO6zZUdQRz467z0pB/sAPRYm2Db3KAHoyJPWRPb1sbDn8gqsLEgXK7r2iA/Pd
         W4HeBdiqaiu/qGlb9xMcbbK+qt1B9K/XAyo2NjqTS4sF7V7DdT1W7OnGDzui2trTOGD7
         qYK07cF1Ucv2HPoCBNxU2pUBAApaHrTUwKb/ifffOfo6lguNBLLqSC1f+eS2t7wVlU7F
         OfzxpAqi7mcmr7jTJi5vB+l/medHmz04xBgE84PHpHaW9AY2Zv+mQth5D+QF/rJy4FNY
         rfZNQCN3QobVIyUoCxi3+tIwFYN3gXJHvIccv7/69WQOP2lxQNeR/NwalHhdnRIvov9X
         WFmQ==
X-Gm-Message-State: ACrzQf3gS2nA/9fjwdxio3ar+O7ALpZQXxj3M8KDvA3DCn46JcXQhbhc
        vIlj4KpDm1vzxYB2DfTZmMcW25VVXbL3Nw==
X-Google-Smtp-Source: AMsMyM6k3eSYdEzEWLMug9CKQBjYU2zgDGFeKo9DwRTD8flgbMPBj/OZ7nRE1caztt0CieR+AWkAaw==
X-Received: by 2002:ac8:5a8e:0:b0:39c:c815:76ec with SMTP id c14-20020ac85a8e000000b0039cc81576ecmr1032675qtc.508.1665685754651;
        Thu, 13 Oct 2022 11:29:14 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id bb33-20020a05622a1b2100b00399fe4aac3esm441022qtb.50.2022.10.13.11.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:29:14 -0700 (PDT)
Date:   Thu, 13 Oct 2022 14:29:12 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Weinberger <richard@nod.at>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        helpdesk <helpdesk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: Add linux-um archives to lore.kernel.org?
Message-ID: <20221013182912.k4deh5v47rjbpnnl@meerkat.local>
References: <20221012191142.GA3109265@bhelgaas>
 <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com>
 <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
 <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
 <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 02:57:18PM +0200, Geert Uytterhoeven wrote:
> The first step is
> https://korg.docs.kernel.org/lore.html#requesting-archival-of-an-existing-list
> 
> It doesn't make much sense to start collecting archives if the lore
> collector hasn't been activated yet.

The archiver is now subscribed to the list. Once we have the archives, we can
complete the setup.

-K
