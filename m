Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C455F5E71
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 03:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJFBqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 21:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJFBqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 21:46:33 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8223F870AA;
        Wed,  5 Oct 2022 18:46:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w191so728677pfc.5;
        Wed, 05 Oct 2022 18:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z1dt20zh03AGkz8Ph70h7KsfwufXO8h3JEFDf/Kqs10=;
        b=iL2nS/EqkduortlDO+6Qdv/SP3d4OWAcLABAXf2GCf+AX7HCP6vzu17/wzQDuiRJmb
         ZUITwoAH1gy7dYEZqSz2t4Ud/d48YHn8/4wFXhlui7RRHZbLBvhHKUmO8flwMHlRnphw
         1wBODHeMoQeuS4YACAV4ym+xcLLk80ZGBf/gPBc5b0nqFnLc3SbBZIGn8Zy+qcRl/tkH
         R5dTK7GY+vvAxWi/q9GxV5nEkSTqlvISKcNiVYJJiI+K73PZF0hNa94q+OGrz02fXpuh
         XKGF9NmoViZehmJFRd8uPEDCqAjs1WHBTV7/BjRvwFn1MR/V8ROgaVWsJeJmKmIQ1KRe
         Ct0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1dt20zh03AGkz8Ph70h7KsfwufXO8h3JEFDf/Kqs10=;
        b=GWgq6T2kt0CJI8Q7mBFc4WckZFhsk0hwLrQ4vP38G5y4ilqrX+uGGG+fWpG9vAl7cM
         EV1kjwFKO2quV8r38rYPsdn0jfn2Vqb/py6xN2UrvXqJbUliMdbyW9OD0COxxlFWQVen
         sxfLB1i1o4VhPficUeThn6AbtSFAKK/3hFT8OkEL/ZvQlVKePUH0ZBWo6v8TUz6aCgPM
         ylC27A4fIroEyG6lK2ARuaFOPGaPtVufoa7Ya+KpXWz7BEF4cwu0PgThUWASZ55gIcdM
         4f8E01OVRRJsSPn7U5HlgdF8UuizoUSf2QxOFwYMHuoQhVFl4jO/1HuaG8JR+3fCz3m6
         pP6w==
X-Gm-Message-State: ACrzQf24QYcQEtDC3sUMd9WERp6nMn52xBdOg0R3wEy1fdOV8KIo5/KQ
        aCe66KgYbQ9L4Io1XDnrIfmbQf26As6NsA==
X-Google-Smtp-Source: AMsMyM6Z1WtaY3aQdyCmGevC34e/UWXrZtye/znSS87qvHSoGQUNyqK0shNDULW1WzkfcLwaAaLlMw==
X-Received: by 2002:a05:6a00:198e:b0:541:f85a:6c27 with SMTP id d14-20020a056a00198e00b00541f85a6c27mr2261190pfl.81.1665020789946;
        Wed, 05 Oct 2022 18:46:29 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-20.three.co.id. [180.214.232.20])
        by smtp.gmail.com with ESMTPSA id c8-20020a630d08000000b0044a4025cea1sm401964pgl.90.2022.10.05.18.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 18:46:29 -0700 (PDT)
Message-ID: <bf4b507a-f996-6aef-71e6-d73fcddc6163@gmail.com>
Date:   Thu, 6 Oct 2022 08:46:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4] Documentation/mm/page_owner.rst: delete frequently
 changing experimental data
Content-Language: en-US
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>,
        akpm@linux-foundation.org
Cc:     akiyks@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        skhan@linuxfoundation.org, yejiajian2018@email.szu.edu.cn,
        zhangyinan2019@email.szu.edu.cn
References: <89aed08f-1e0b-258c-516d-97a30fd02840@gmail.com>
 <20221005145525.10359-1-caoyixuan2019@email.szu.edu.cn>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221005145525.10359-1-caoyixuan2019@email.szu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 21:55, Yixuan Cao wrote:
> The kernel size changes due to many factors, such as compiler
> version, configuration, and the build environment. This makes
> size comparison figures irrelevant to reader's setup.
> 
> Remove these figures and describe the effects of page owner
> to the kernel size in general instead.
> 
> Thanks for Jonathan Corbet, Bagas Sanjaya and Mike Rapoport's
> constructive suggestions.
> 

The credits paragraph above can be removed (should be between
dash line and diffstat).

Otherwise LGTM.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
