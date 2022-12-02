Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CADA640710
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiLBMqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiLBMq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:46:28 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F6FC9369
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:46:27 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f7so6308559edc.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 04:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLtDRcAl8DeDPXZz6+GdQ6+OhHovb79Hg4rX6E/CdL4=;
        b=Qobuymnaf0WMEeLqC68rknZLiSmModI5nO9U5mkhBlna50hek89QRyMiDgPQ+H4miL
         /nbalqs/bOIYclfpuboNF/vDL75V/7Df1+g5/S17nUYVZBgczawLymGe/B1H5cXoXA5g
         TC6xYSlhh2pc3j4zteNYfZXJKpKixHLG774Qt8ixhLWL1qtWl2UjKhDtiRbGQk/GnP2G
         xsrMtuZh9bcYxPLzEoz182T3N9wvuxl3Ihajocj28FMpl72iTKFdgV3qHQb4nW4nyBRI
         laT8K+dFE+8iuCdvqLhd6XfKs1uXg+SDBwBoMhEr9BLjmeGGDF+oJXaQoOYCkg03+qHb
         IZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLtDRcAl8DeDPXZz6+GdQ6+OhHovb79Hg4rX6E/CdL4=;
        b=cKN/HaCaRSU+Y6IoIWPHxcx3gOVWv3VCfr6+9ZZHML8fBj21ozf5Rxsyz4zuI1jOk8
         dfBpRfryD/grNLW5o4l8L//nZYpbdgQlVde0LhipepoQgK3uKpSGjfnlyOJfVKQVd/ZJ
         bOHHOBAG4Zjh9C2R2+mWXfYGJR0mFViLb/ZKDJgRO3zCIHlLRHaR2EMDLUIUSU3+qi+z
         1PUOSwkKu3RXzNjUfK7QelrigVlto300xH0L9mB6ic8TckNhGVe5JXUA2uu0jP0no1TM
         qf2AQyFu2ii/VlC6i949nUkYSj9fXQSoulet7e1KxEfO4cKYVmGksAl02krk1ciaVKW0
         zOQw==
X-Gm-Message-State: ANoB5plmbE48ny1bF3RNoAi/8f48fwQjJm+kfbUbD3uql3uHgIo6mwnV
        VYfuiePTsEMtmtQAi1Hy9i4=
X-Google-Smtp-Source: AA0mqf5eAy64DVIwNwLMElDz03Y/QsFKV8XDNVzQADx9NUovE5hLKGPNwfW6SVYTmgefrv3wbywepA==
X-Received: by 2002:a05:6402:1593:b0:46b:fb7d:2188 with SMTP id c19-20020a056402159300b0046bfb7d2188mr5834720edv.395.1669985185769;
        Fri, 02 Dec 2022 04:46:25 -0800 (PST)
Received: from debian ([86.48.7.129])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0073d71792c8dsm2957640ejf.180.2022.12.02.04.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 04:46:25 -0800 (PST)
Date:   Fri, 2 Dec 2022 07:46:23 -0500
From:   Petar Gligoric <petar.gligor@gmail.com>
To:     Ian Rogers <irogers@google.com>
Cc:     linux-kernel@vger.kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/2] perf script: introduce task analyzer
Message-ID: <Y4nzn6FGS0/2BcQP@debian>
References: <20221201193557.65548-1-petar.gligor@gmail.com>
 <20221201193557.65548-2-petar.gligor@gmail.com>
 <CAP-5=fV374SjiMQPsba3Tw2qJwtT8sXneRKAyqnEtCAhJ6FaUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV374SjiMQPsba3Tw2qJwtT8sXneRKAyqnEtCAhJ6FaUg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 04:05:15PM -0800, Ian Rogers wrote:

> 
> Thanks Peter, Python2 isn't a thing any more. It is worth knowing that
> for python3 you can test old versions easily with docker:
> docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp
> -w /usr/src/myapp python:3.6 python <script to test>
> Python 3.6 is 5 years old and what the jevents.py script aims to
> support. This allows type annotations and f-strings, both of which can
> make your code more pythonic.
> 

Good to hear Ian! We have not removed Python2 support, because we still use
the script on older installations where (unfortunately) only Python2 is
installed. But good to know that in future patches you don't have to pay
attention to python2 compatibility anymore! Which Python version is the
baseline? Python 3.6?

> Given the new functionality of this code a test would be useful to
> avoid regressions. You can invoke perf as part of a shell test:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/tests/shell?h=perf/core
> The perf command found is the current running perf command, as its
> directory is appended to the front of PATH. Could you look to add a
> test? You could have individual subtests for the different command
> line flags.
> 
> Thanks,
> Ian
>

Great, I will create a patch 3 which will add test support - I already
have a test script. I have to dig into the test system first and port
this script to the new environment

Thank you Ian for your valuable input!

Petar

