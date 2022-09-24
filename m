Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC21D5E875B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 04:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiIXCUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 22:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiIXCUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 22:20:03 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B843AE61;
        Fri, 23 Sep 2022 19:20:02 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id k12so1187515qkj.8;
        Fri, 23 Sep 2022 19:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OpEPvLv/O1HM7B+SRN9luBqj0c1Ggp5FsG5boA0jORs=;
        b=dSLACMSBNFqztokANX/Dos2MCMLrRji8o8WrI/cCU0p4Qy32BQ9VyOGVbEPptxseip
         40G7Bkj1+J7MtCn+XWVBxumYJLZ4OQwWmVejOlHmGIf68LfaBEs3ktYAfHXeUKlkTizJ
         Outv1hVlZ2XOcDg8296d6+dGVneBr/x+rznMYyQgM3JrnMjaiiJBj4aE7PjB5OH0WC8B
         BbK0EuYpE2uS9cu+Rh7ldObW1zyo92u5BPxwOuybG0dknTtd6ZxOKazleTUM5U8NTIFK
         lbzrD4ZC+M18k+NHp/1hSH2Jubg47oNyFkluB0XavUNsFKngD22NcViXnEH5/y6N+UVt
         L0iA==
X-Gm-Message-State: ACrzQf2jIGlGidzgHSv/LGTYDFrsErrhK1YOp2GxoojL8EEwezLO/BCC
        JVVyxko6N1CCvwvurCxPgJBufeng5j80Rl5r
X-Google-Smtp-Source: AMsMyM6H705+Uolyv3bgv+4nMOV24YAB8AvLp9Fi9/fJiLLfWpE/od8oqIPL2zqCBBCfsG+OumHDdQ==
X-Received: by 2002:a37:348:0:b0:6cf:f30:9f0b with SMTP id 69-20020a370348000000b006cf0f309f0bmr7874862qkd.735.1663986001110;
        Fri, 23 Sep 2022 19:20:01 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::2c58])
        by smtp.gmail.com with ESMTPSA id h11-20020a05620a284b00b006bbc3724affsm7012664qkp.45.2022.09.23.19.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 19:20:00 -0700 (PDT)
Date:   Fri, 23 Sep 2022 21:20:02 -0500
From:   David Vernet <void@manifault.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 5/7] docs: move asm-annotations.rst into core-api
Message-ID: <Yy5pUi+9M50eVSNS@maniforge.dhcp.thefacebook.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-6-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922204138.153146-6-corbet@lwn.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:41:36PM -0600, Jonathan Corbet wrote:
> This one file should not really be in the top-level documentation
> directory.  core-api/ may not be a perfect fit but seems to be best, so
> move it there.  Adjust a couple of internal document references to make
> them location-independent.
> 
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: David Vernet <void@manifault.com>

Certainly seems better for it to live under Core utilities compared to
where it is now.
