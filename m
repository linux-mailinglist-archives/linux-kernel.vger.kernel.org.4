Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8A764963D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 21:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiLKU2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 15:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLKU2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 15:28:04 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694B0E4A;
        Sun, 11 Dec 2022 12:28:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id js9so8908582pjb.2;
        Sun, 11 Dec 2022 12:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=by9IvQrNC4n3hMJPqWVgJdj265wMQ5fsMcjx5CkRMb0=;
        b=Gvluwy8JmJ35C4rhygAyMhL+GuwkXWeHQDfujZWe2lpeshB2WQwe8zU/oDmPrdNcNz
         CD6szyiJYLnPouNh7PdPMCRSQXLtRZQ74900pzOfX9tJiRNXq0R4SnMzTFMYe3Q9sYWs
         nuqQKIgkZasvDWg3OnLuLZwUcCHlvrxpWUicdx1b5rYcZcCFjjCcg5l1b52gBZ/7wWjo
         577wUQcVyQ9CruX0RRyH5m0J+F9oixQ/Ea3HWdnF9ZpV4yJScVDkQJceaepUkJlrEkcq
         d9FfFWRoboee96aSzpYxNwux8m3l0kNJTjbf15fwYKTetvqUSS/QNa64NluQ3HHIPINl
         AJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=by9IvQrNC4n3hMJPqWVgJdj265wMQ5fsMcjx5CkRMb0=;
        b=vPsk2/GUUIXG8+SazL6ejyb9vixOZ0blMEY9QqNDkKnlcWt+YPUOKv4ubBc3iKjsN3
         yLp1hnfiqnPwdrOMcHhfll63DpxoRewHOzUl+SMjljz2vwc4SrCnOlLYMnGz2dzkEblA
         QDlHJniLxRfTIZy8mcPg4/06OL5ZN6yQAEsuT0VmyQQDgn4DHa+OfNU2n7hc141322DU
         wjUuvfG17ATgLBP7P8PPNnVnT5JdBXZoA483DONICFbnFmNVb8Lg44LlDvR4RyULBsP1
         xnbIcLBbmMbLiDCoEO8mgxd6zvQHmpTnmus7HXLa8pI/R67hJyQlVi8nYu9DwgJUaeZu
         iGzg==
X-Gm-Message-State: ANoB5pkJz0dCcSVpKZjBm05DuW8JcLBVxTqi6RdrWQVyhcazxZI1dA2Q
        BSqFQvNyIB6g62+Nv0R/VB0=
X-Google-Smtp-Source: AA0mqf4GK7azKp1g/5pH5O5L6eYpB3GPoNtYfq1K6iRvncnGG1DylBHg8K05syopNMajOeARdzRoUQ==
X-Received: by 2002:a17:902:f285:b0:189:f0ac:191d with SMTP id k5-20020a170902f28500b00189f0ac191dmr3559258plc.4.1670790482873;
        Sun, 11 Dec 2022 12:28:02 -0800 (PST)
Received: from mail.google.com ([103.229.249.253])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090341ce00b001754fa42065sm4749908ple.143.2022.12.11.12.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 12:28:02 -0800 (PST)
Date:   Mon, 12 Dec 2022 09:27:55 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vipin Sharma <vipinsh@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/tags.sh: choose which directories to exclude
 from being indexed
Message-ID: <Y5Y9S0qSOAL/KHp1@mail.google.com>
References: <Y5T66yWNVAZNIaJ0@mail.google.com>
 <Y5UP+tnnxNgoi6A2@mail.google.com>
 <Y5VazQnY7s4+cXdM@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5VazQnY7s4+cXdM@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 11:21:33AM +0700, Bagas Sanjaya wrote:
> On Sun, Dec 11, 2022 at 12:02:18PM +1300, Paulo Miguel Almeida wrote:
> > This patch makes it possible for the devs to specify which folders
> > they don't want to include into database as part of the
> > find_other_sources func if a makefile variable IGNOREDIRS is present,
> > otherwise the original behaviour is kept.
> 
> Better say "Add IGNOREDIRS variable, which specifies which directories
> to be ignored from indexing."
> 
> > @@ -278,6 +278,13 @@ To get all available archs you can also specify all. E.g.::
> >  
> >      $ make ALLSOURCE_ARCHS=all tags
> >  
> > +IGNOREDIRS
> > +---------------
> > +For tags/TAGS/cscope targets, you can choose which directories won't
> > +be included in the databases, separated by comma. E.g.:
> > +
> > +    $ make IGNOREDIRS=drivers/gpu/drm/radeon,tools cscope
> > +
> 
> Use two-colon syntax (::) for code block above to be consistent with
> other code blocks.
> 
> Thanks. 
> 
> -- 
> An old man doll... just what I always wanted! - Clara

Hi Bagas,

thanks for taking the time to review this patch. I will make the changes
that you've pointed out.

thanks!

- Paulo A,

