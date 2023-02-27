Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D4E6A463D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjB0Pkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjB0Pkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:40:36 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E5220063
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:40:35 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso4053892wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RUcgyHnJ/etaK3uhEjf+YLIhFfUz/wtE9tXC/7i2y4=;
        b=eYmxO3RVhN+9zhwM5ArERLU7dZoGWYvILsipaXZqKC0f5H/Hh7w+4huvsSS+9ze+Fo
         xiFyVTgzrWE1g3UFhXBYsB8k704hHvxc9MIdTwz/ljBz1sDQ0j8PxBwsTn5FTXzH36NS
         LTuS8FfrG39niY77a2/7Q52o7rtd56YJr8c1ulUA7ctwzgo4ojUOJL+vQoo0AGDlS9bb
         e3pbiMSF4PZkOx+xlZGNqzwUGGqidSjSAFYEf5sFSEVTysoR1jKtBuitc8lLljHLx32y
         gJfThtCZZ8LaRXLoI7F/wkWj8+PTEz/Qjitb5fVErUOF9vSpLJBNmf3+NL22PGua95HR
         FpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RUcgyHnJ/etaK3uhEjf+YLIhFfUz/wtE9tXC/7i2y4=;
        b=7xWPpt/dSjRnnFe0042kES2YmoD8Y+K+Yohb4oWupanKb72QDJFFwJbfA/r7BBxupz
         GEzU/DLgDdDXk6bxH6JjZFivHIiRhOiEkhnGpkru2KMlFV8QTCj3IEZYMPXi+YSkteK6
         KZy1OyO+UmI91SajFPmFiuLRstP1LReO/l/yovkPcJRDVPdN8kBgB0ofE0nY24UFoOCW
         co+kGbv2hf4leKb0vWRguls7ISy1FvrcXA9CNqJw2EcRvlhvSPHAkaBFm1G0nu3fxlki
         vCBLhADM1drrq1+Hi9w1xkXHkR4P49U2Ip9v3F/VK/7bGkxWzSvzkI3iVFQQn7RylmFU
         p7Ow==
X-Gm-Message-State: AO0yUKW7BbYTohptohaehn7As2gGs/awDsckRByxvLiGlV1nvQbV+iiS
        waZTujGLwshIUho5km1Ep61OuQ==
X-Google-Smtp-Source: AK7set+xkQaw3K9W4KXceG2A4gYhxl/0iXrGAddB++6wpIhQb8MhDW08DsWxj+JIYLwYNs8q8mPYIQ==
X-Received: by 2002:a05:600c:3d1b:b0:3dc:40a0:3853 with SMTP id bh27-20020a05600c3d1b00b003dc40a03853mr6964126wmb.11.1677512433593;
        Mon, 27 Feb 2023 07:40:33 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:3c9c:c8a4:3574:9374? ([2a02:8011:e80c:0:3c9c:c8a4:3574:9374])
        by smtp.gmail.com with ESMTPSA id ja18-20020a05600c557200b003eb0d6f48f3sm12429618wmb.27.2023.02.27.07.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 07:40:33 -0800 (PST)
Message-ID: <ceadeae8-2478-0d96-b6be-1b330bbbc2a2@isovalent.com>
Date:   Mon, 27 Feb 2023 15:40:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] tools: bpftool: remove invalid \' json escape
Content-Language: en-GB
To:     Luis Gerhorst <gerhorst@cs.fau.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230227150853.16863-1-gerhorst@cs.fau.de>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230227150853.16863-1-gerhorst@cs.fau.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-02-27 16:08 UTC+0100 ~ Luis Gerhorst <gerhorst@cs.fau.de>
> RFC8259 ("The JavaScript Object Notation (JSON) Data Interchange
> Format") only specifies \", \\, \/, \b, \f, \n, \r, and \r as valid
> two-character escape sequences. This does not include \', which is not
> required in JSON because it exclusively uses double quotes as string
> separators.
> 
> Solidus (/) may be escaped, but does not have to. Only reverse
> solidus (\), double quotes ("), and the control characters have to be
> escaped. Therefore, with this fix, bpftool correctly supports all valid
> two-character escape sequences (but still does not support characters
> that require multi-character escape sequences).
> 
> Witout this fix, attempting to load a JSON file generated by bpftool
> using Python 3.10.6's default json.load() may fail with the error
> "Invalid \escape" if the file contains the invalid escaped single
> quote (\').
> 
> Signed-off-by: Luis Gerhorst <gerhorst@cs.fau.de>

Fixes: b66e907cfee2 ("tools: bpftool: copy JSON writer from iproute2
repository")

I see this escape was similarly removed from iproute2's version of the
file [0]. Thanks!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

[0]
https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/lib/json_writer.c?id=49c63bc775d610c3dfd3db0d6501ac29c519967f
