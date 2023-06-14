Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9C272FDE7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244382AbjFNMJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244141AbjFNMJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:09:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549201FD2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:08:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f649db9b25so8347580e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686744536; x=1689336536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJuVpE4jMb4TfTBLTiIyFyMVUfAwRk7NmxAOLH+UOaM=;
        b=aMCuv7D0SqlRUFsiNpgsgtg9e/NC6E10dFIoU2gUjluO7MwjZpGOkRVWXq5p10vuEZ
         qEnpKehcMsgZerqYFPnltqCe28WfNP2sBXh0CrVpSETYif9oyBfRneYczBgkq4ceQfJB
         uOSfO4l6TjelazoAJoqjjiFfzDN4Kdk3f3qhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686744536; x=1689336536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJuVpE4jMb4TfTBLTiIyFyMVUfAwRk7NmxAOLH+UOaM=;
        b=VagzzQeUbXKKYfEq4gUBxGNsGhcXZ3lZp6niTQUATVF1agG/jYPd8aI0p8FlBwAQME
         r8Gz66Tw8DpcqHjJ8OeM+atKtpw9WcrIuwhz3cGgM2vctjT0O3u+XbtQoWtgQbu6wLR3
         00m+Uohuon0jcqpr1hZRmd2Iex/irqDKs9MsHEaKKKs1jU0mSprn2x+7/9bFnDrJXi2e
         IkS4At/tPUFwPDs6S+LaKvdG89qmjCM1NCqR7xCIvesjP2EK0LAxqWv73MJmPf9fZzxi
         JKBX8wsbSR2U5tdZltpL4Yq2rGT2HYdNYb4RPEZXhwwbRv2eTyKoxNuzsloNCzlRltXp
         1+Zg==
X-Gm-Message-State: AC+VfDxDoaAu9MFyGagT9QCcPmSLikZO8HEbYbWWr4llfyYbnGX32dhh
        yeeD9kIMkBcQg+c/l1ACCGBKbw==
X-Google-Smtp-Source: ACHHUZ5qKjJmrWCBmlquhxEr/HQhIYAPY2mDM2OYJtUV+E5n0jUYEobZtoRxtgNxF12zQPIMIvjUNw==
X-Received: by 2002:a19:3848:0:b0:4f6:2722:9a5a with SMTP id d8-20020a193848000000b004f627229a5amr8109230lfj.57.1686744536506;
        Wed, 14 Jun 2023 05:08:56 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a2-20020ac25202000000b004f60d782681sm2099015lfl.221.2023.06.14.05.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 05:08:56 -0700 (PDT)
Message-ID: <c17a115f-39ff-0925-c886-b34f38643b1c@rasmusvillemoes.dk>
Date:   Wed, 14 Jun 2023 14:08:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
Content-Language: en-US, da
To:     =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org,
        danny@kdrag0n.dev, masahiroy@kernel.org, jgg@nvidia.com,
        linux-kernel@vger.kernel.org, joe@perches.com, willy@infradead.org,
        mailhol.vincent@wanadoo.fr
References: <20230601075333.14021-1-ihuguet@redhat.com>
 <87sfb1oz13.fsf@meer.lwn.net>
 <8f27ad5f-9a9c-3db0-a934-88e1810974f3@digikod.net>
 <CACT4oue7DgUf+65yat+6t9VrSji1N0njxunObHbRzfjMCAPmYQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CACT4oue7DgUf+65yat+6t9VrSji1N0njxunObHbRzfjMCAPmYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 13.40, Íñigo Huguet wrote:

> I neither think it is good to enable it for some folders and not for
> others: developers will be surprised of having assistance in some
> files and not in others, I would be bothered with such inconsistency.
> 
> Right now I see 2 possibilities:
> - Provide an .editorconfig.default so those that want to use it, can
> do it. But I wouldn't mess with cherry-picking directories that
> already complies and those that don't, just the developer chooses to
> use it or not, and that's all.
> - Provide an .editorconfig directly, and those that don't want to use
> it, either disable it in their editors or manually delete the file.
> 
> Please tell me what approach you prefer.

So opting out by deleting the file would leave the developer's work-tree
permanently dirty I think. So if there are editors where one cannot
actually disable the editorconfig plug-in, and we worry/care about
those, the second option seems to be a no-go.

The first option works better; we can add an ".editorconfig" entry to
.gitignore, and then have people who want to opt-in make .editorconfig a
symlink to .editorconfig.default.

I definitely agree that we shouldn't try to do anything per directory.

Rasmus
