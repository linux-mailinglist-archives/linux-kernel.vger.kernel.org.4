Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972E36E0CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjDMLqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDMLqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:46:11 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC9D9768;
        Thu, 13 Apr 2023 04:45:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o1so18757708lfc.2;
        Thu, 13 Apr 2023 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681386357; x=1683978357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H7H6EEWl/da78+Pg7xNj0IrBs7xeLiKGn3zRnzUagG8=;
        b=kCIYnalT+WTO9slQRE7xgKUgeYq/TzsPQsxROt1i5/4rFyxunHIIjjN+6Rkm9gOQzP
         lLGfFe0XbJ3MzVldIvpLyc+vbZUePjC0lfxRqr3Zb7DjHoISB28fR6kVWV/GVbQ0jDsR
         OavePCCWvEd1BxSExJuy4X1xfmi8W5/zEkB16ECw9Nu+gDfeXoSCfKV4xLZCAfdCjc8u
         DODk3LNWuy3Q39/rG0hhiUBcQJNg5Yg3yRPnLuLnl/UcQAhLg0ZI0enJmjpZ80PF8e39
         qcLKtDRo6uku8+W3ixJMSnLSkBMsZKapqvbjGq0M/kqhql0+Vvl0M7n9t47wSwA4YItc
         6jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681386357; x=1683978357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7H6EEWl/da78+Pg7xNj0IrBs7xeLiKGn3zRnzUagG8=;
        b=XWtxDbyjOCc3qyM981o+z9N1BRmu5mGTGM7RWCT3X7cYRv6onzVxyDMR65wb/EKD99
         msM4v5H2YQ+6yZ/5TXZ19Wm2VkFp+iV2Nx8x48yg6xjGqxd/U5AEKeVZNq1vH9mpBmhF
         9fkgZwCZx1X1Xq/+TdRqGirl+d6jHyeZXgAziFXMnPUFb2FA4H0Dj7KsaCJG9qXh+EMW
         Q9I88g/ITMSR9MykL4xnabXucxmG8J27AAAffn2Pg9vPbwNh4ICeYLUOZseNTItKqQPe
         vfUPKRfnyGj5oeSVqk8nQrsQ4ShduoPdHDr1w7HxL0pxLQ0Jzl6fv6qobpGdtq/Wb7Y9
         Urmg==
X-Gm-Message-State: AAQBX9eBuqnaV7t7JxxGPUtCzxOKbvhg1NA940gVIurEijLnNQFQshlC
        hG13z1My90bdbNxnFNaua63B42bkTHM=
X-Google-Smtp-Source: AKy350aIh+HynqigKv6iyR1AuPUVYAFjO4DeXYG+CDcEEbsm5Ewqp1LjQ74Ir9IGwS6TQpZnFD8K1A==
X-Received: by 2002:a05:6512:1021:b0:4e8:4699:d01 with SMTP id r1-20020a056512102100b004e846990d01mr958752lfr.27.1681386356717;
        Thu, 13 Apr 2023 04:45:56 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id f9-20020ac24e49000000b004eb018fac57sm274822lfr.191.2023.04.13.04.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 04:45:56 -0700 (PDT)
Message-ID: <97379cbb-ea61-ee66-56bd-f2dbe3e282b9@gmail.com>
Date:   Thu, 13 Apr 2023 14:45:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel i2c
 LED driver
To:     Andreas Kemnade <andreas@kemnade.info>, pavel@ucw.cz,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230413110307.310944-1-andreas@kemnade.info>
 <20230413110307.310944-3-andreas@kemnade.info>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230413110307.310944-3-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 14:03, Andreas Kemnade wrote:
> The device provides 6 channels which can be individually
> turned off and on but groups of two channels share a common brightness
> register.
> 
> Limitation: The GPIO to enable the device is not used yet.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

