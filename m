Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638A96D08C0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjC3Oxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjC3Oxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:53:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C462EA2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:53:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r11so77586181edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680188016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kf4j1XV1zBAvKAeKkAtDa8lDI5sOqBXzDIOXiVOIMdo=;
        b=pAjs55hpk1du9S7H97QKxkiStU0LOS1YlvodKIzibAp3keecnAMdcj+2ZzDWYqmpTD
         Z3GT8XnNtV0Bl3Ob6r1bBy1y8kIPDU0TTO0rgFBYhzvYt6NpfHbuB14auA4Dwfmd48KK
         0Z1H47Jw2Q+S5X1o3zH7M1yjPnx4NP+H4pzIW/zRYsm3zkSWPYePkhT1s1Us9fyozzsF
         1js6MJ25ojpT972FeXJn0pQGUGN5KbVKIhH3wZ7ByAfnuXirrMagn9oDKbCZKUTw+gWS
         OcR+PgHwYCTrb8phNE6dOSoxNBg8zXpJqkCuST0zeW5D1DScWW4x0Jk08b87yPSviiJ/
         bPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680188016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kf4j1XV1zBAvKAeKkAtDa8lDI5sOqBXzDIOXiVOIMdo=;
        b=PZvKVZL3CAH8TCC75jibqnt/RD8aQrCBG7TTra/rZMaZsA+FxCiQketFInvVRm8lfs
         HKMBvq/2V2pqp4FskCSOEt5WQAuOTU7zT4i5SE58YmWWqzyr6eUezIDNasic2w0i+rzx
         EEegZ0xu3OqZrPRYfPi1nHVBvw+edG6c3v8FuFRIvAFkFrKvzDKndlOavjepICGLflkI
         cZPOtoOPlWb54C3f6WBLdEKA1gZME8jP8FFtHbNxhSn5ujeO5dH1/dbZZ9ItIAuKzpNn
         ghV54VbVn++VHbwRYdbx8L9aiDaWt5238HSecagi8Gq9iJWJbe9IWRhegUPnEY1NSil0
         mY3A==
X-Gm-Message-State: AAQBX9epYL47x8w1Zq5kNneghc/lKsO14pPM+Wvtak2T/bUbR0focCFO
        N7CsnLGXlbIFD6KvCJkXrtzh5iejNIPi9Q==
X-Google-Smtp-Source: AKy350Zlre467MsXUK7sMLFincwSyv5+0dUst3Q22xu+yckgqnetO5EzRIbGIReA4ggho2Be2w9vPQ==
X-Received: by 2002:aa7:db94:0:b0:4bb:e80c:5667 with SMTP id u20-20020aa7db94000000b004bbe80c5667mr23376928edt.10.1680188016170;
        Thu, 30 Mar 2023 07:53:36 -0700 (PDT)
Received: from [192.168.32.129] (aftr-82-135-86-174.dynamic.mnet-online.de. [82.135.86.174])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709065f8a00b0092595899cfcsm17759565eju.53.2023.03.30.07.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 07:53:35 -0700 (PDT)
Message-ID: <ecd044c9-2fc8-fc8f-98be-c96e0622ad2b@gmail.com>
Date:   Thu, 30 Mar 2023 16:53:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/3] mcb-pci: fix memory overlapping on MCB devices
To:     =?UTF-8?Q?Rodr=c3=adguez_Barbarin=2c_Jos=c3=a9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "jth@kernel.org" <jth@kernel.org>,
        =?UTF-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?= 
        <Jorge.SanjuanGarcia@duagon.com>
References: <20230330104949.21918-1-josejavier.rodriguez@duagon.com>
Content-Language: en-US
From:   Johannes Thumshirn <morbidrsa@gmail.com>
In-Reply-To: <20230330104949.21918-1-josejavier.rodriguez@duagon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pushed to mcb-for-next.

Thanks,
	Johannes
