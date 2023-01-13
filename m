Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC86694DD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbjAMKzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241126AbjAMKxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:53:39 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CDD7682F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:51:53 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ud5so51436829ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/C6SpuoHZ9Y6cju1o72xmhKwZ/eCPDzqDGgxZpC4yhA=;
        b=Y8WBqMyFLvjqL4YrjHXKZgYwRc+nyi2sXodioe9YtEGlSQG65wRlaZA5isREH9Bdm2
         rqwYsA0Meu2zGIpq0mWbg243/ehMJ9lfxb25WUio/9rFqq0jjc20OaoQp3f1/gqKgm7M
         LSx8UnWmEvke2b6eYpttNqGTdjpG1GDeER2Vpxc/45IQ7rGl4/59JkgFFM/bGJokfbUH
         fTShONbxkSk/NJ0rkH+qeaZf2TKjBB2sjqLu46/rtLGkeVHnTuObCiFrNNzsTFmHF+Mu
         ESGSqEYKkmcgw1uZlqQgfzsVFcIIrdg/5rlOYLnImF8+EB+rUYCxqQMoOfPCrjNCN11l
         dJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/C6SpuoHZ9Y6cju1o72xmhKwZ/eCPDzqDGgxZpC4yhA=;
        b=Nc8XWZMI/5MVG9/yFW33bpbO/eIT0WMds5Xu2gIbmOsi74/8Oz7k1EadyBzdFVLTBZ
         okghrv2DdwAksr9lIe3ev5h2jC5jvg+/QzRAi6M4JWiVME6Rrgc8U92n8ogKoxfOUB3e
         1v6XfChxhtggMxiREEa0PIPc7tGMj57nPWqNVai3T56krY8P57XYSUCYFs0o5EdIW08t
         U3DsdkCUCWAAcNphKbjztDwjHzDkxqkub0K/uZRFLl18jtSbU4xXm0iI7yYpLRkjvN1G
         /zCgnH8ymAJvEt4ZcI5xfoB3HiscrgDUsPf/35sHCi3kqYDrrfdwd1O18mJ2KcKyiyBZ
         98iw==
X-Gm-Message-State: AFqh2ko7dFvm79rlTpWTQ6Wt4x+dsAdkX/q6Xwvgj2t2rCE8DLlff3R7
        apQx/XKM4v11IEoYxwJ/G329cw==
X-Google-Smtp-Source: AMrXdXtYpd+JAmfWhlqcFa8tWfQMF/hnwAOhsVEmMl0Wc3WRX9D9Si0s5fbB0FDUXdVzlIAs4v+XhA==
X-Received: by 2002:a17:907:cbc8:b0:7c0:f2c9:4404 with SMTP id vk8-20020a170907cbc800b007c0f2c94404mr79625032ejc.21.1673607112507;
        Fri, 13 Jan 2023 02:51:52 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0086b7ffb3b92sm146352ejh.205.2023.01.13.02.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 02:51:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: socfpga: drop 0x from unit address
Date:   Fri, 13 Jan 2023 11:51:41 +0100
Message-Id: <167360709872.32944.12649774614219791842.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221210113349.63971-1-krzysztof.kozlowski@linaro.org>
References: <20221210113349.63971-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Dec 2022 12:33:49 +0100, Krzysztof Kozlowski wrote:
> By coding style, unit address should not start with 0x.
> 
> 

Applied, thanks!

[1/1] ARM: dts: socfpga: drop 0x from unit address
      https://git.kernel.org/krzk/linux-dt/c/189d80108620722ef43d11307db18ef29df49916

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
