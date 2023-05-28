Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DA17139AE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 15:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjE1Ngo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 09:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjE1Ngm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 09:36:42 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FF4B2;
        Sun, 28 May 2023 06:36:41 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6260a2522d9so10543436d6.3;
        Sun, 28 May 2023 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685281000; x=1687873000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2n/WoDLxYIs5byxeZJLkV/uF8fU1oTZ8WCiBG786KWU=;
        b=Ri6l7Zx7Zq5TyRhM1oOvRL6b6/CiRhjnyFwXpUFCKl9dN82foHPdn49IeTDonA+M4z
         9IyzYufFo5m2DJv3Xj6qB55Ixp6cH6iceqSFDts2NNo/GgqJT4SYB2LC1rzr03lezx2s
         C3U+sIIucSQKaxVIG8u2Y4K1xD3M1LJNfYeoW+pDSQ+koTLc+npw7WV7YY0AO+ck4r6s
         zyLg12MI9QNCwrtGnChOV6mHEh7KYrNa1CSQhF2Bo2W3zhtw5M3hRFz9LdPq4FZdzyny
         k/5RpJ8/gTqGr/S+c/nOolxJemNP6Vytr8OsUy6axFIBjSiOzMDM56HcwsoqwNTMIfX3
         4vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685281000; x=1687873000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2n/WoDLxYIs5byxeZJLkV/uF8fU1oTZ8WCiBG786KWU=;
        b=I06tL+XGztLmQ1B9SSMLe+WDP/mk1I1YLKvAjZJIRJNLuc1JAFypXpi+lSo2Gzu28U
         J8Gpk0gTHzi3EhNF1tC8Pph6PiTT4LpMru4HFD6irkSirk3ep6nhSFwWUWQ371EJN0XT
         LSJ5PA66/juXR/7egK6CFKWddgLP+7jIYdiqN9M4p6BmxTSGqUEzYKRbH1HTnO31TGO+
         sd+pY109si5de+DRw2xxGcK3rjEjGzwqOYQsHEkpYye9a4g+dQxpdFEgqtzfw6EefPdk
         diW0Y6yZckDSmd0J1I47qhnAamaXkdc8dK3QQPdPnC5e/5BXvwQ9yWOZCKt7gbI9ryr1
         9QCg==
X-Gm-Message-State: AC+VfDyVr7C9nNMMNiL9Ei+UaHD/HPP+5mUFQrUZlANnEvAkrC+A3ByZ
        TSqNodgzG5MHqxVVLQqS/RC04kSaHxBhoA==
X-Google-Smtp-Source: ACHHUZ6XUZe6ez6PJp2Vl27vedty0Ud/1hhdxDFc5ChSTJOKCw/jzUz5Qav5ZBXkf80FRvXpjxUbeA==
X-Received: by 2002:a05:6214:500c:b0:626:1589:68e4 with SMTP id jo12-20020a056214500c00b00626158968e4mr4422550qvb.43.1685280999942;
        Sun, 28 May 2023 06:36:39 -0700 (PDT)
Received: from ?IPV6:2600:4040:2007:9800:ffda:b634:1d9d:77a8? ([2600:4040:2007:9800:ffda:b634:1d9d:77a8])
        by smtp.gmail.com with ESMTPSA id k15-20020ad4450f000000b006260e7361ebsm1661935qvu.1.2023.05.28.06.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 May 2023 06:36:39 -0700 (PDT)
Message-ID: <ad7a6ee3-cabb-6f92-a595-8791801cfe97@gmail.com>
Date:   Sun, 28 May 2023 09:36:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: qcom: Add Samsung Galaxy Express
To:     Conor Dooley <conor@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20230527040905.stmnoshkdqgiaex6@ripper>
 <20230528001010.47868-2-guptarud@gmail.com>
 <20230528-decode-creasing-f5b3996163e5@spud>
Content-Language: en-US
From:   Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <20230528-decode-creasing-f5b3996163e5@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > Where did the "att" come from in the compatible. Is this some carrier 
specific model of the phone?

This is the code name for the device. Since there are usually multiple 
variants of a device, using the code name differentiates between those 
variants. For example, if I left this as "samsung,express", it would be 
unclear if I am referring to the GT-I8730 (code name: expresslte) or the 
SGH-I437 model. This is typically done in postmarketOS: 
https://wiki.postmarketos.org/wiki/Devices and XDA developers. I believe 
it is a carrier specific model of the Samsung Galaxy Express.

