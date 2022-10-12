Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785FC5FBF10
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 04:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJLCLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 22:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJLCLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 22:11:08 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E603A804BE;
        Tue, 11 Oct 2022 19:11:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b15so14070685pje.1;
        Tue, 11 Oct 2022 19:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aIE38xJWkCdqxxneRAkMVomCE+b6T/zcmJrJOxJI7rw=;
        b=DuiFK0GNi+mGD/KR25IFzOBnXMUU60NHIquyd2uEu87NINp9NmYBe6iShN4s3khHW6
         ppclqry3Ja2dtOl+MR12puqTs9OKhgAj0OTIRQwnDPGsVW+5kz3baJ+D+yAMoZbFWfgF
         HPlm28gP0W+oeWYlBdTWU5PMCVxOl1iEPqyzCet6OQfK2nyZv4YWdGkVkYOK8Mn+nBkw
         RPHPnG/3b0M9yCB3W3rkdD0slnGESJDkLAaUju72SyNCQNRoqW2d2oUdf2OBwJmZBppu
         8cBQ4BzlsjMxJtUSxcoJ+hvv4tIdrdWbgr9Kf2iYtpSEQwUrlSvinA9nTAVRrujtlGOh
         WicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIE38xJWkCdqxxneRAkMVomCE+b6T/zcmJrJOxJI7rw=;
        b=ou8NLq+9C59XdsT6Lb4Bk7k1VkqsjPUxRXLrvdUKd3yHQp6zNqt2+tXXjwJm9/GjBK
         HfWx51MZcVKlDcLpB5HE16BDzrZYAHWLuVH5dOcrwAsMIFADs5UMqNiGQCoxRerbX8gp
         hvyhLyZqlmm5J5Dm0aj96fCxto/lFQ+nTW7rY6gm8RbFjxP5o7zDS8wPMS+NheC3WK5Z
         ut0gG0blMWdnMtfhkV9DDnRL/O5HI+o12jCZcghdaE84j4x2OeK1kB7NHT41qUkoSheh
         OKyBF/ka01ZoibHXaW9d535DZ00y0HueYDY6vxEApJ/a9XE5LXv1qt3hiav06qN4uvzp
         tbbQ==
X-Gm-Message-State: ACrzQf2xkX1pB5LG2TL94lVJtbuNPRH/33LekbPQGGamQNO3nyW6Kfay
        Fqk1sq9IwhflDli+M0qYyVntqSi0f8AYkg==
X-Google-Smtp-Source: AMsMyM6982Ih6F03nM/2FVnpvrd8L8APLg9Z0KlqqkR+rAVSg/kOK6Tl9fSuTUsvB9t9GqhDf/ogVw==
X-Received: by 2002:a17:90a:e7c4:b0:20d:451f:a988 with SMTP id kb4-20020a17090ae7c400b0020d451fa988mr2321358pjb.57.1665540663388;
        Tue, 11 Oct 2022 19:11:03 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id r3-20020a63ce43000000b0042b5095b7b4sm8555094pgi.5.2022.10.11.19.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 19:11:03 -0700 (PDT)
Message-ID: <3c65451e-c9bf-55ea-02af-f375346c955a@gmail.com>
Date:   Wed, 12 Oct 2022 09:10:57 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 0/6] docs: Improvements to our HTML output
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20221011190047.749145-1-corbet@lwn.net>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221011190047.749145-1-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 02:00, Jonathan Corbet wrote:
> For a long time we have rejoiced that our HTML output from Sphinx is far
> better than what we got from the old DocBook toolchain.  But it still
> leaves a lot to be desired; the following is an attempt to improve the
> situation somewhat.
> 
> Sphinx has a theming mechanism for HTML rendering.  Since the kernel's
> adoption of Sphinx, we have been using the "Read The Docs" theme — a choice
> made in a bit of a hurry to have *something* while figuring out the rest.
> RTD is OK, but it is not hugely attractive, requires the installation of an
> extra package, and does not observe all of the Sphinx configuration
> parameters.  Among other things, that makes it hard to put reasonable
> contents into the left column in the HTML output.
> 
> The Alabaster theme is the default for Sphinx installations, and is bundled
> with Sphinx itself.  It has (IMO) nicer output and gives us the control
> that we need.
> 
> So: switch to Alabaster.  Additional patches adjust the documentation and
> remove the RTD references from scripts/sphinx-pre-install.
> 
> The penultimate patch changes the way that kerneldoc declarations are
> rendered to (IMO) improve readability.  That requires some changes to
> kernel-doc to output a new container block and some CSS tweaks to improve
> things overall.
> 
> It should be noted that I have a long history of inflicting ugly web
> designs on the net; this work is a start, but I think we could do far
> better yet.  It would be great if somebody who actually enjoys working with
> CSS and such would help to improve what we have.
> 
> As before, I've put a copy of the rendered docs at:
> 
>   https://static.lwn.net/kerneldoc/
> 
> To compare the kerneldoc changes specifically, pick a page that includes a
> lot of definitions; for example:
> 
>   https://static.lwn.net/kerneldoc/driver-api/media/drivers/frontends.html
>   vs.
>   https://www.kernel.org/doc/html/latest/driver-api/media/drivers/frontends.html
> 
> -------
> Changes from the initial version:
> 
> - Tweak more alabaster style parameters, including the maximum page width.
>   There will surely be disagreement over what the right value should be,
>   but at least it's defined in units independent of screen resolution.
> 
> - Remove "classic" theme configuration and a bunch of other conf.py cruft.
> 
> - I've tried to answer all of the other comments, but a couple remain.  The
>   sidebar contents are unchanged; making that more useful will require some
>   thought and work.  The gray background on function prototypes that Jani
>   pointed out is actually something I did intentionally, with the idea of
>   making each declaration stand out better in the wall of text.  I still
>   think it's better but am not married to it if the world disagrees.
> 
> - I've tested PDF and epub builds (no changes) and Sphinx back to v1.7.
> 
> In the absence of objections I'll be putting this into docs-next after the
> merge window closes.  We can (and surely will) tweak this forever, but at
> least it, I hope, shows a direction in which we can go.
> 

Hmm, I can't cleanly apply this patch series on top of either Linus's tree
or linux-next due to conflicts on [1/6]. On what commit this series is based
on?

-- 
An old man doll... just what I always wanted! - Clara

