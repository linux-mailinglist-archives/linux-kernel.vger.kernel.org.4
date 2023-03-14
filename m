Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3286B89AD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 05:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCNEdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 00:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCNEdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 00:33:53 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A293E84F7F;
        Mon, 13 Mar 2023 21:33:51 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w4so8112030ilv.0;
        Mon, 13 Mar 2023 21:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678768431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8PZTSwVqx4WfnMPNMhhp7877sSPb77XSlzX/q7SN/M=;
        b=ZT87dnfV6t6YVzTC9C4hB3NbzZxk4bfADzP/CTl3mthyPnqHvrqosZRfVfjttc686l
         nXG63le+1licMpLpHkpauv3ULjIivAr/NqywqhfyLiALQauSakk5WEpm7nzeYRPSQBxL
         S8JWFitZvH9F1tH5lJBMkHnJMZ1kbeLaF5lVJVb35ENDPd5/F7Y08w7eX5L+/kfWALJw
         jNcpQFbMlLh0hrt/KIBOniFqw4ztioQOp3xzCFoyxbMh1UWuJblxdiSAk+X6BJyzI6kC
         m8NctGfSPjBsL79F8LWdu/d8A9eSSVTgpAChetJ+sIv/6f/BCCaog+kM5C2P4eXj01TA
         7isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678768431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8PZTSwVqx4WfnMPNMhhp7877sSPb77XSlzX/q7SN/M=;
        b=KMYEoovyXbiydrR3Y7kEj/ZbS8A4TFXlSFt5w1OiHe79ZEHdrjC51HKYViqkVZ8Ofo
         KV1L5rX9M2EWFtcYAWUC/F5TjBZiONguZJ8CqTjZwFlQjbE5M6M5yVjlLSwmKNmCoh76
         ouUXJwQBXnkM29sUEdSExTicgACYocDtAMbvy4GofZsr3QSuHB1B3Rxp9tcLqaYMPWWU
         dDHm8kRO7yrP6Aenp1IpPYf0TzEjTJYR5mrstZy6XiUh7lOCBnP/n6OVix6LE6HmRWsY
         wwTII6JjRKE9kR48lZwnc65DIc9Zo0oaIfoWsgZ/zHj2EfPe8/qo7wS+eXcpoGwXVVle
         v6sQ==
X-Gm-Message-State: AO0yUKUTkkfCp+GLQpe4q7NG0+jiTNdNfOcesjuobItgCYg4GET41afb
        iO83poa9z2e51aPHikqRwu0=
X-Google-Smtp-Source: AK7set8FXSc+V3smK2C+v01dZ3LRh7P7fUD12d+hH1SoaIX54KJpAdVr3VwN2Zr2T4oDXq/O4LFGqA==
X-Received: by 2002:a92:d186:0:b0:323:504:cff6 with SMTP id z6-20020a92d186000000b003230504cff6mr3292521ilz.3.1678768430873;
        Mon, 13 Mar 2023 21:33:50 -0700 (PDT)
Received: from ?IPV6:2604:2d80:4d87:cd00:9f51:32d7:1177:67d? ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id p23-20020a02c817000000b003a60e5a2638sm459557jao.94.2023.03.13.21.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 21:33:50 -0700 (PDT)
Message-ID: <7c400847-e803-c903-18de-e1b03c89e0d7@gmail.com>
Date:   Mon, 13 Mar 2023 23:33:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/5] Input: add driver for Focaltech FTS touchscreen
Content-Language: en-US
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230312093249.1846993-1-joelselvaraj.oss@gmail.com>
 <20230312093249.1846993-3-joelselvaraj.oss@gmail.com>
 <ZA/tCDOceYUZI88N@nixie71>
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
In-Reply-To: <ZA/tCDOceYUZI88N@nixie71>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff LaBundy,

Thanks for your clear and in-depth review! It has been very helpful. I
will address them in v2.

Thanks,
Joel
