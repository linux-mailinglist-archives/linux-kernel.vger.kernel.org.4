Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CF66AAEEA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 10:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjCEJzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 04:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCEJzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 04:55:52 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15336EB42
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 01:55:51 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u9so27069987edd.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 01:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678010149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SaiCZo/+1YA/uk2vyGLpxGSRliJ9pY9vxuYVZhWCjpI=;
        b=TWvwQKWi6F9tRrBcDHcjKZmTm+Z+ZXiASZY0ROOG1pH+G4cghvi8fiOawjrbjK3JjT
         BRs/SuxOVbnt/3N7pjqy92tlpjlf7AEpYXUHBB+Mw/BQwVqRJ7UrHyIAPKQWJ7GeGADg
         T+UU5BdbruMktGDrtxCNVWzHxBmuaP3KQxM990WkMvgoVJrZNclMuH5qUFy73n4A1nwD
         0PDKTrVuL5FlsSc4vjFnv2QcxbqxNrLFscDN2gzwksXVqWZu8blco6hMA48sHwWwIIxd
         Pz4WgstQhAOx+Q2l2yR/DeKp5CrDMPNmSVwLibfhWWOLf9XEKuEA7JnsKIA7nnSr6hjf
         5Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678010149;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SaiCZo/+1YA/uk2vyGLpxGSRliJ9pY9vxuYVZhWCjpI=;
        b=7ksxozh1F1wsEMTKgMwXLvy5U+Hw4fMGmnhCUvN+uPyGdcaenMqQJ9Cd6Wgjrnw0fA
         PxzepnikRrsNpyB2GC+cdHRO/8swAvuoW6gQ28tb0VQVH7WgRRzjsS5Q22ulc77XD+tA
         ymt3lYe0MVXltVctYkDCCfaY0KyWgHJHwntl3sy10FtWR+txcRhNrWCjhGq2zZYq8vcY
         svmzg8b28jKM+5sxUgxF9a+Udg0KvEvzDGO9XOp5UDelVzI7zVZimoP5lXFJnX/bXcuO
         cqgMm4zwhwN8ChExSygRCHb+VwlqnMuhBtfxY1JxKyZeXYURFxrhJ5zoazwgNaCqRG8G
         duYQ==
X-Gm-Message-State: AO0yUKU+/Ph9+pBNWVa+YZMUV1MAZEzjUyAruRJUYXJkp0bF9sNkDV9N
        uzIiVWxL5IArCKmrqOOlJ73lATMmOgsL+any1Fk=
X-Google-Smtp-Source: AK7set+C3D5+JtstYgkM4mOMlB7yc0ER4V44acEGOOuTGZ8p3QsibWZ+oyRvCVhN7MQ3TVZ+2e7DFw==
X-Received: by 2002:a17:906:29c:b0:8b1:7274:1a72 with SMTP id 28-20020a170906029c00b008b172741a72mr11376470ejf.6.1678010149625;
        Sun, 05 Mar 2023 01:55:49 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:71e7:13d:1c29:505f? ([2a02:810d:15c0:828:71e7:13d:1c29:505f])
        by smtp.gmail.com with ESMTPSA id d5-20020a1709063ec500b008b1797a53b4sm3015368ejj.215.2023.03.05.01.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 01:55:49 -0800 (PST)
Message-ID: <4f6b5931-e023-07a7-d593-d7a0b12499bb@linaro.org>
Date:   Sun, 5 Mar 2023 10:55:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/6] dt-bindings: clock: Add Hi3798MV100 CRG driver
 binding
Content-Language: en-US
To:     David Yang <mmyangfl@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230304063333.162309-1-mmyangfl@gmail.com>
 <20230304063333.162309-5-mmyangfl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230304063333.162309-5-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2023 07:33, David Yang wrote:
> Add CRG driver for Hi3798MV100 SoC. CRG (Clock and Reset Generator) module
> generates clock and reset signals used by other module blocks on SoC.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---

Same comments for subject as for previous patch. With fixes:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

