Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CBA6EFBF4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 22:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbjDZUzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 16:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjDZUzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:55:31 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCCE1FE6;
        Wed, 26 Apr 2023 13:55:29 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-541b60e0a7fso4128533eaf.1;
        Wed, 26 Apr 2023 13:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682542529; x=1685134529;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7BDHHCRt4+aajzCfPWxNu1orJw4/MC8hMj/R8/hq0Q=;
        b=hJmHaj8bMSyyd1pbrp/d/AV15mwTKEOwMJPLuTsvFfgdodrp+bLrkLD0PJrIgbXEgR
         QPUYr7KZ5uRaVfLcN6nkQkpi4AG2iYRveH6DIAaZFjKHu+6KuFGi59qlZCAYgLZ3uSN4
         spFJRw+tsIn2tjEgYOYlzTNKC/NYAxw05S6lhGWiIeSVjbU8P94GObnCglXqOY4kx8ge
         RZZGybKpRBQYxqSSE+hEdUCFmeDmTEBE6/jtjbwx0aKm4Ln8D2SsENt7K3qqC4V08QZ0
         HkGTXwCae6hgflRzB380uvjl5/3bo3QhhcQlX4GYPHFQ7jZ7jNbcmKo6E57WwJ0gi2E2
         JHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682542529; x=1685134529;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7BDHHCRt4+aajzCfPWxNu1orJw4/MC8hMj/R8/hq0Q=;
        b=cTBryZqNI3SoNvIJQikhf9jM5S6E8E2NFS8AFXi7FKgmdzL+grFyoGJsiFfxO1NaHq
         1LHQ9IxZLUn2o/ReBdusVaSsb8eSVE2ScDVQwvKkZ4G9ZHCOiK0PvxcaeA+iqZye2iro
         vIpBH+2MtzTPiatdc1/SFesUsckd23a+aeCraPhI2ggnpYM4Z4yh9v8oMhq0Z+JAYwjA
         XmlwFXQLaXSFCWjsZ77Klr9V659OPEZcxJBLtewzeOF+fiXbWfJlIqltDUwsNpa8IBcJ
         HfV43E0oYIyEFVCPV1wGLByzztDzFvSroPItIztsXSmUywXlhlSraw6VnZZboGzOfCl8
         1o+A==
X-Gm-Message-State: AAQBX9cuOGiRtEnUoc3+nmo8ZjIvYcYdqEI+2DOQYAAUHuaS9bfpmFje
        TiWKnkt6tM3iQkQS5w+JyvM=
X-Google-Smtp-Source: AKy350ZBvklTH3Zq7nm6uj53wA0YTB3dSTdpbO/3rQMj4/PKskuHIj+Rz0UoC8xQfqL03EucEkLGwQ==
X-Received: by 2002:a54:4489:0:b0:38e:8e30:677d with SMTP id v9-20020a544489000000b0038e8e30677dmr8468566oiv.3.1682542528807;
        Wed, 26 Apr 2023 13:55:28 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id q9-20020acaf209000000b003908004b37dsm280080oih.26.2023.04.26.13.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 13:55:28 -0700 (PDT)
Message-ID: <4b8e3c30-9626-dffd-0aff-4b5c650154ad@gmail.com>
Date:   Wed, 26 Apr 2023 17:55:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] rust: helpers: sort includes alphabetically in
 rust/helpers.c
Content-Language: en-US
To:     Ariel Miculas <amiculas@cisco.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me
References: <CANiq72nm-tWGPHMaNF11baVRDFpk8ruvTAVDEWKfraEzADWqQQ@mail.gmail.com>
 <20230426204923.16195-1-amiculas@cisco.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230426204923.16195-1-amiculas@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 17:49, Ariel Miculas wrote:
> Sort the #include directives of rust/helpers.c alphabetically and add a
> comment specifying this. The reason for this is to improve readability
> and to be consistent with the other files with a similar approach within
> 'rust/'.
> 
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1003
> Signed-off-by: Ariel Miculas <amiculas@cisco.com>
> ---
> [...]
Shouldn't the link use the `Link: <url> [1]` format? Otherwise LGTM.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
