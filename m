Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFEA67AAE7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbjAYH3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjAYH3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:29:17 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F2115C83
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:29:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o17-20020a05600c511100b003db021ef437so590437wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/zYb3mbFmjgoGxZfiqbziu2v8uAqk6hubRFYbxoSlc=;
        b=t6xI6eMY7T3NthJ8wINZKhVY4l2iBv+ao3N88MgKk0VGCKAVAjNjw8mNfFy8BTBMrG
         XgidFiiVBZBy+anLYqLhffAZjms+FGkPzTpgdgnOnKSncoQUPWV1lcSdkygzL6EmuW9I
         4YPGTwFyfLQOaUhDJF3SpXECnzEX6vwCg3ET5kHJ6xam4Puzf/80T1ksN+VLIA6uATxM
         ZIPYrNJhgunMvk8sPM11Gxirc6WS1IrmdvW+3qz4dhYDIXvg9He/GVuvPhOyqetY2ajJ
         Q0QJkv8Dp6PCcbuqv+Sc2JLYlFXFqJwX6hoB35vzT0V8JsJlK22MFGGMsMDn3OWfyhm3
         N3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/zYb3mbFmjgoGxZfiqbziu2v8uAqk6hubRFYbxoSlc=;
        b=eTy54N6FZucVWUeMkBnkmliac4tHBTQtJJx6QJrXHJQdAdv03FkLUszeJNJ+K5xzj4
         k70CP4FMbB62ZUgFJYk51QhXv3PsTY8lLULwEbJ4Ta33NdtjKteikVjWwSocLHo+in5Y
         d7/ohC1yLAmsGW5IuuSp0x/DqUam1JbXi5HQ6OCa/EiTsod+CDgiXLDTfX8K63pQ73bV
         RqrUpa3TkUPqJzwzOs72AP3N3BfW3P3zRjvxfPny+ovjUzkHKkDwj6SSXQTLORhqztyh
         ND9lVmOhP3toK1dEynI7w6j/FdHIW0H8xSz+6ZDDnn6VWZkxj+nSf72x38wdJqXESn0I
         xrvA==
X-Gm-Message-State: AFqh2krzlCnxBeb0Qs97awrEHB8a/mCpaDjd9bwXJ59Be8HS/xYrAro3
        y0AiVcrqAoxqPfmeus6F5OlwZg==
X-Google-Smtp-Source: AMrXdXt9SGOwxEXr5Ol6TM9T8P204nWihJ4QLUqzCiu7G3/To6p6IruhCE/rq6883y/w0Ulpsu1yqA==
X-Received: by 2002:a05:600c:c05:b0:3db:2252:e50e with SMTP id fm5-20020a05600c0c0500b003db2252e50emr23239325wmb.24.1674631755424;
        Tue, 24 Jan 2023 23:29:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g9-20020adff3c9000000b002bfb29d19e4sm2778121wrp.88.2023.01.24.23.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 23:29:14 -0800 (PST)
Message-ID: <90125055-929b-fdd1-3489-cfdc913594a5@linaro.org>
Date:   Wed, 25 Jan 2023 08:29:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 2/2] dt-bindings: display: simple-framebuffer: Document
 physical width and height properties
Content-Language: en-US
To:     Rayyan Ansari <rayyan@ansari.sh>, dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20230124224142.7133-1-rayyan@ansari.sh>
 <20230124224142.7133-3-rayyan@ansari.sh>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124224142.7133-3-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 23:41, Rayyan Ansari wrote:
> Document the optional width-mm and height-mm simple-framebuffer
> properties.

As pointed in previous discussion - you should have panel node and take
the properties from it. The physical dimensions are not properties of
framebuffer device. These are properties of panel.

Best regards,
Krzysztof

