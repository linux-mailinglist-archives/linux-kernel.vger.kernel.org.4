Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EA76CA920
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjC0Pfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjC0Pfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:35:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DD5189
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:35:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m2so9238680wrh.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679931331;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8N0hw4+EMSVtCyZmq7J5HduUc9xYRvfHTSgJBWJto70=;
        b=6TAtyyrRhTgXGlXDflWGtkR6vdqzDTcQXvrMvSCFyT809wO1uDB8+q7Ol208GnrjDQ
         jdR9pVUSe/+Bkl2YkjNcBDPStTK54dohQt4Xf8imHMBJSlA2jqnwvVBtL2Eo/XTTnTuy
         ifjjDeRJkvJgouPPhm9PZsh7/UFkU1X3uOcQ5iNIDmHDdPKNje/IJfkfU2bPnnW+bODu
         7y6iNXTYQeNECKahRh81jTTpbYCwKDuUrT6y58MvmJK7+SZ+jQaCJCUfID6d/PPQ7eyM
         s+G4V92W5xzHn3korVCP9Fy9JYNJ49Kz9ckzIblaDaw1xxT2FnxHT94xmgaPtvet9k0l
         1baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679931331;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8N0hw4+EMSVtCyZmq7J5HduUc9xYRvfHTSgJBWJto70=;
        b=fO6PqVABH0zx2CZKy6oYqxTCJOD4LHT/+FG3AYIBtOQqJey+irHmhgONW8FPDi8Jrm
         mBAFxetWkDx+yk+hAeJUk01olyl/oxQczLf9aI/u3HWDc0ZqXtecxvYjEKUjcI2Flkr8
         Orls3AKi3xNJ3nXaqByYXXlLoCRsmbvB5aj1RBxf9PbuGe3SQvlGY/V7eMnI8h/D4jf3
         WwvE1BqeZMFds+bmDzDouU2P/eaM1PdOcC43DJKGiyLtAgELy19Vs+pkFbhEPbAaXCoM
         QPsi64iBKYX85dAdmhdAjgzzFL/4yZbt81LK0JmyNTD+p18/ZTnR1EHgG0jUNNFYSpdX
         Zi+A==
X-Gm-Message-State: AAQBX9cE6awXOPpRsOLvL6oK4eK/Z7JU96iapbJw63/Ll2wz3BNyEuQQ
        8OKbWIU+WDMOuzjmvHBoXC6ZEg==
X-Google-Smtp-Source: AKy350YJn17Drgd1PMAWXHDxj5oFw5AMn5zFS9BIUMVYNI+vwzGpQHTMb1wO4ytJZFVcUx3HPRdxQQ==
X-Received: by 2002:a5d:4291:0:b0:2c3:db98:3e87 with SMTP id k17-20020a5d4291000000b002c3db983e87mr9522092wrq.20.1679931331232;
        Mon, 27 Mar 2023 08:35:31 -0700 (PDT)
Received: from [192.168.1.70] (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id e9-20020adffc49000000b002be5bdbe40csm25374042wrs.27.2023.03.27.08.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 08:35:30 -0700 (PDT)
Message-ID: <2ea21982-485a-d052-2e25-84907e263743@baylibre.com>
Date:   Mon, 27 Mar 2023 17:35:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/4] mfd: tps6594: Add driver for TI TPS6594 PMIC
Content-Language: en-US
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com
Cc:     eric.auger@redhat.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, davem@davemloft.net,
        christian.koenig@amd.com, contact@emersion.fr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com
References: <20230321171020.74736-1-jpanis@baylibre.com>
 <20230321171020.74736-3-jpanis@baylibre.com>
In-Reply-To: <20230321171020.74736-3-jpanis@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/23 18:10, Julien Panis wrote:
> This patch adds support for TPS6594 PMIC MFD core. It provides
> communication through the I2C and SPI interfaces, and supports
> protocols with embedded CRC data fields for safety applications.
>
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> Acked-for-MFD-by: Lee Jones <lee@kernel.org>

Lee, I will have to drop your ack for next version (v4).
A bug will be fixed in tps6594-core (a couple of lines
will be added/moved in 2 functions, it will be explained
in the coverletter changelog so that you can easily see
the diff).
Sorry for the disturbance.
