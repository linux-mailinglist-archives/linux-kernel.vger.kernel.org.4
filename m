Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A47669857F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBOUYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjBOUYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:24:40 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459358A63
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:24:39 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id co8so16656298wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CY6JL34+05ZutGH4b4w3uUc4dNGAvqRNs71sw+XJV5E=;
        b=p0NuNLGeIiNPB5WqgDRjiFM/bwDPcUQu6zYFUajET34tWBE7Xm/dyU9FNgs0TyZ6AJ
         RF7aEt8KLWxdL7ZwbO2VuvjI1z5dc5SMh/7q1osa4HZo3DVBFu73gQO6Lq0uonChDUsi
         RJO1HhBwHtA+xb0+6VEPGPKi3vHaBuEzKnOiJ1fhN2i7CW00Dafji2TZpB0kqPGzLb4Z
         jOBOnxe+cTtB7CV4mYlcox/g0pjMKVAUA2vXnX/lzLYrLy8E/d58dY1/uVfqqZRpR/iI
         uK4oDGGpYYP91kLv0V7ZInIgBPezwT/TMfJRP5mNw8TiUOAvCJ1NZZ3dGNLcjNUiVprU
         wU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CY6JL34+05ZutGH4b4w3uUc4dNGAvqRNs71sw+XJV5E=;
        b=T2aGgGvpnjJ1ei0IEwNHEPy3iyhf0nH8gLDaIGm68NI430+iT8qe/I0UYw1XtJ/wln
         AaJTEmzpb1GWRy8gN7WVoWQtaFSZ1zhTtlj+Bf5bqo0HHXr2qTDv6TCpkvC1SP4ViGrW
         QLDzqF/lQWL417DgDcwBDsuQh+9l730ETg99mjSeJLPoO21/yFWj2e2Ad4dC0xp9gu+R
         ZyJnEdzbkU/oGOSn3VgdJ8lswGcbYmKTd19+ztIwDWi5h5yvLCC3WTyWFh50vKgoBafW
         htMw19BZtuQqIJRzHh81OfZhUKjCmWAZnT3jHr2/D0ibiJQ+6J4i/SegLzViw0Y6zNH4
         HqRA==
X-Gm-Message-State: AO0yUKXuM1j6/uKSLMZOmCBcybZVnKq3gqxDDfNMZiga+R6738iw//lG
        jdMrnl3MI5NZ69SBhGzvqLmXZA==
X-Google-Smtp-Source: AK7set9RbhuagyYiHFUSwwI3kdKoottE6qkGYvfMtZ624U/WicDoI3LqQ4K18skzS337+C0BpIYL+w==
X-Received: by 2002:a5d:40cf:0:b0:2c5:594b:10d1 with SMTP id b15-20020a5d40cf000000b002c5594b10d1mr2636526wrq.23.1676492677768;
        Wed, 15 Feb 2023 12:24:37 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z13-20020adfe54d000000b002c567e3808bsm4507094wrm.40.2023.02.15.12.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:24:37 -0800 (PST)
Message-ID: <9f2debc1-6040-3182-5945-36e668eac171@linaro.org>
Date:   Wed, 15 Feb 2023 21:24:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] dt-bindings: mailbox: sti-mailbox: convert to DT
 schema
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230214204945.4215-1-avolmat@me.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214204945.4215-1-avolmat@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 21:49, Alain Volmat wrote:
> Convert the sti-mailbox.txt file into st,sti-mailbox.yaml
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> v3: remove quotes around $ref
> v2: update commit log
>     remove quotes around urls
>     add mbox-name $ref
>     remove mbox-name from required properties since not mandatory in the driver
>     fix IRQ type in example
> 
>  .../bindings/mailbox/st,sti-mailbox.yaml      | 53 +++++++++++++++++++
>  .../bindings/mailbox/sti-mailbox.txt          | 51 ------------------


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

