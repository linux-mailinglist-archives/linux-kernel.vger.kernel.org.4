Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648A8701582
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjEMJN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbjEMJN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:13:26 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE91930FF
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:13:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc2feb320so16592129a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683969203; x=1686561203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXTHGE0Wl3MaP4uQCGWbuj/wOoT4T39v9HX0v0hxJf8=;
        b=C44D9GW14rmvbs7slqJlRtWSEfFd9m39+QRGn2224B3WZhCy2QWUpTUK/lBtbqxYIC
         iUZQ60xpLSaDuao6yvw1CKoebvNp5k0jXXOp31Cs/rcab+fomOK7Dk6edkGti7pS6h+U
         rMh8qN+jlW0Z9aHfGw0ktcUVqK6KcDablHWy99+cx3sDFD5Z1s1T65/72xMgqVojPav0
         lTahVG0K+dus6WDboiXKl0DVjo1Z9ClI2zt5MtjQNUtg5p7hRSVHulltwjriTq38DGNf
         FIRLNAwqnCRlpjEFLRCHqORBLnDV/PpYOQ1XptPRFE2BB+waXZUF/XUb3ew1gETvNgyn
         7EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683969203; x=1686561203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXTHGE0Wl3MaP4uQCGWbuj/wOoT4T39v9HX0v0hxJf8=;
        b=jVOOJ072/+AvUZIjgTgyumXjAj+bTVCn64ADLFCJ5z0Tv10Za92f9lGBS/Tn9dNB6d
         VONR7cHdTXWarah2dNksAHS9rPaOWEx7dPlWGYrd4JxsGdPzEztUoIHcNOb8C5F8/Fil
         sXdzDdj71ZN548HF4DHGaTA8aPhxPxr9TITHrKwFHCBQ2cBQNILOE5F+3Vlq+gW6fu/Z
         LL+ApuLy0I44ktHpM7HOi40bcoz422TvQWgsla/LEJ8TEyT+7FXNt3udsFShaWtzUzvh
         DJFZ2iG/DzvaI2VjZGuJJs/RnjAgqxZ3wDVrIy5mLv1MeHYXL7cz9b4Rww0yD/vrjv79
         c14Q==
X-Gm-Message-State: AC+VfDxrxJuYbi0Ji+eEQ9naL3ddiS+Vl5W1Kt8f09cpKg7HrPWORiBZ
        D1nuEnkTR/nHG8MYy5QQ3vVqwQ==
X-Google-Smtp-Source: ACHHUZ7jtwC+5aOEbgSa4I23nZNu1ofmb71WzoHsdxR68vtuGufCicwFl3Sq/PA8VrfW+/qE2RKTQw==
X-Received: by 2002:a17:907:9608:b0:969:e95e:e4f3 with SMTP id gb8-20020a170907960800b00969e95ee4f3mr17483776ejc.55.1683969203257;
        Sat, 13 May 2023 02:13:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:1d0:810a:586c:c5ba? ([2a02:810d:15c0:828:1d0:810a:586c:c5ba])
        by smtp.gmail.com with ESMTPSA id ib10-20020a1709072c6a00b009531d9efcc4sm6538708ejc.133.2023.05.13.02.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 02:13:22 -0700 (PDT)
Message-ID: <65cf0de4-42b9-2b25-ac16-9e2ddfcfdb93@linaro.org>
Date:   Sat, 13 May 2023 11:13:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] docs: submitting-patches: Discuss interleaved replies
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Rong Tao <rtoax@foxmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <code@tyhicks.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Xujun Leng <lengxujun2007@126.com>,
        linux-kernel@vger.kernel.org
References: <20230511184131.gonna.399-kees@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230511184131.gonna.399-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 20:41, Kees Cook wrote:
> Top-posting has been strongly discouraged in Linux development, but this
> was actually not written anywhere in the common documentation about
> sending patches and replying to reviews. Add a section about trimming
> and interleaved replies.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

