Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652285F2715
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 01:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJBXJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 19:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJBXJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 19:09:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE750491E2;
        Sun,  2 Oct 2022 16:04:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o59-20020a17090a0a4100b0020a6d5803dfso3764183pjo.4;
        Sun, 02 Oct 2022 16:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zAw0fVVkmmXAocwS/FBx/4RAeRzhHAr6z6st1vR4ywE=;
        b=khZbRIT/bthChLI0FdE6CkcXt+dUJCAASmqfgzKlA7ZaxpHQcJHxB8OfM+SjfdZcmA
         MefLF+sFLCeZlBdWlPrWVuhVfmqVFkfzooIllrVqhWSxleNa/mVfcVZx89h4Td7wdTPW
         IVROBfiao7Xr9ulFWytB5f1FqffN0hqmrhMRdkO6msmxAkyjudUkky+YmJcdJNmVBN46
         ILBsHDBRKJGxpA0Nwys2mlkWaUEeWqYlLOjjvqGDbrrzXcjikR7GPXVfuVk+UzjSzyyS
         /emwt64eZkwbYxc9lnPJZ/70RZqOa7VzA4VN4JCI7EnMqeN40U6x3RD6BRHwLx+9tGcy
         YmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zAw0fVVkmmXAocwS/FBx/4RAeRzhHAr6z6st1vR4ywE=;
        b=pDEsJ79iQTg44oANr8WcdPtwluTjdjEO4ZFpFzJctBGoMcAUy8tynA2roOz79m0jL9
         pvUmTQRzIFBFmaRbp7wwg0y5dRUHzXPRA9I0904WGNeIP+OeU0BwEUrWYdY1l9/ECpxi
         K1d6l/Upl4O7Rcv2ZgVMPVxbTW0CCiYO9Xx6UkbHqKUsXJKfXgYacwN3lCkKOncyG2Oy
         SR5jEO0EaXIB+3kPe2Og5HsnH+itA/8zVcdUl6mDHZd7Rb+RYXWFlvKD6OCpgVLrUl49
         rlgDZnkSkDe9ejxqu0sUOX9xAYNTa9VGhdfbuK+BCVCr8yVIllGhGqLFyHv56ftG8BOJ
         /5TA==
X-Gm-Message-State: ACrzQf0lEHz11Z8sScNllZNAHRUhy3R0M6gDh1Q/FL3iX0empsOvVDf3
        RFnywoJGMDO1U+sSbb88sxM=
X-Google-Smtp-Source: AMsMyM78cbNm24P26f6BhXyWocR9twEA+NbsyH80uQdXHN7DsoDnA/h93AqMAv7zchfQZELBm/Xrsw==
X-Received: by 2002:a17:90b:4c46:b0:202:b9c5:2f24 with SMTP id np6-20020a17090b4c4600b00202b9c52f24mr8792035pjb.180.1664751851217;
        Sun, 02 Oct 2022 16:04:11 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id c6-20020a63d146000000b00440507bb7fcsm5431495pgj.31.2022.10.02.16.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 16:04:10 -0700 (PDT)
Message-ID: <de5e732e-4857-dc69-a6c1-f0c1d52f99ef@gmail.com>
Date:   Mon, 3 Oct 2022 08:04:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] Documentation/process: Add text to indicate supporters
 should be mailed
Content-Language: en-US
To:     Joe Perches <joe@perches.com>
Cc:     corbet@lwn.net, konstantin@linuxfoundation.org,
        Theodore Ts'o <tytso@mit.edu>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux@leemhuis.info, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20220930064629.329514-2-bryan.odonoghue@linaro.org>
 <21f8d79a-0ad4-b28b-15d8-f4be0cfd9730@gmail.com>
 <b119fee5-807f-1940-3378-f5ad638794f5@linaro.org> <Yzen4X1Na0MKXHs9@mit.edu>
 <70759d05-2646-57e5-0b87-3a196488f622@linaro.org>
 <dabbb4aa-d5e1-10d5-082c-1386f3314fc8@linaro.org>
 <f7f6a67c5ee662f24885579ba09b281a5d597b0a.camel@perches.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <f7f6a67c5ee662f24885579ba09b281a5d597b0a.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joe,

Thank you for chiming in.

On 2022/10/03 0:49, Joe Perches wrote:
> On Sun, 2022-10-02 at 09:58 +0200, Krzysztof Kozlowski wrote:
>> The easiest to achieve it is to run with --no-git-fallback and CC entire
>> output. However it does not mean submitter must run with
>> --no-git-fallback. It is only for this generic rule - CC entire output
>> of get_maintainers.pl.
>>
>> If you add such rule "CC entire output of get_maintainers.pl" and do not
>> mention no-git-fallback, some folks will think they need to CC all these
>> people who made one commit to your file...
> 
> false.
> 
> git-fallback is _not_ used when there is a listed maintainer for a
> specific file.
> 
> If there is a use of git-fallback, it's because there is _no_
> specified maintainer for a specific file.
> 
>    --git-fallback => use git when no exact MAINTAINERS pattern (default: 1)
> 
> i.e.: It's not "your file" if you don't maintain it.

Joe, I sometimes see unexpected output WRT --git-fallback.

Example:

    $ ./get_maintainer.pl -f Documentation/doc-guide/sphinx.rst
    Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION,commit_signer:1/1=100%)
  <-- ???
    Lukas Bulwahn <lukas.bulwahn@gmail.com> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:2/2=100%,removed_lines:2/2=100%)
    <-- ???
    linux-doc@vger.kernel.org (open list:DOCUMENTATION)

    linux-kernel@vger.kernel.org (open list)

As you see, --git-fallback is used in this case. Why?
It looks strange to me as Jon is listed as a "maintainer".

Having "F:	Documentation/" in MAINTAINERS does not suffice?

Can you elaborate?

Regards,
Akira



