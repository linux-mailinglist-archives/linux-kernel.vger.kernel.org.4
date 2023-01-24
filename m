Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082CF67A5A5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjAXW1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjAXW1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:27:34 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C7F37B48;
        Tue, 24 Jan 2023 14:27:33 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-15ff0a1f735so11146551fac.5;
        Tue, 24 Jan 2023 14:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QYzhrVnn/TY2Z5kM6uHGUFL5kwZuEGKyu87043mT1ZQ=;
        b=cIGvlQmaaiEqC5V/4G5Lr1T6F65HXZJPeGHaQHS+dac+N8DztqppB82k7MxXnivBwC
         FFBHSuZUBwWfLZS26Fku1zffVyQCKsm0nVt8u+QT++d8TzSywJ1Tb6A2WRifnO4HzG3T
         YdW5tKU4jYcot3mbAV+Jm+4bqNtOZ4YKQzjGzRxCTL+cNsEgKH55XCwOz1D3WA0C9VgS
         fW+KfBRr0CY5iktem3H0V1aV0zt4WWiPkSg21xfGnNTq88CVlsnLL4VLiMJhmJqBQ7cF
         +Jjf2FjSKJmc3LAMT/z2WRtON1uOt6BShOK3/F2bzpxwsFqsq9HfUkUEEq1mTevasmJA
         v7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYzhrVnn/TY2Z5kM6uHGUFL5kwZuEGKyu87043mT1ZQ=;
        b=Izkc78Vthpjs3mxqQIZN6/kvCDIo2EHaMzIi7sJ1HU76t2ixfekAaOHVn+mzXapMdl
         9nf5m1/fBbMF5szb/z+wA75aAk9VzButeLg4XIyKuhF560uSbwVdhqi3b4AW655N4AUX
         DkqjfeTP99FBl5Ujb3CoB+lKwDUGz/Im2pJb8pPc0+pO7zJPOhcGkNbKxLYD6tE6KDsZ
         byd23OrqjIFVVBCUQwOssGG0aJDCFkihcK5+5YPdTkMsZ0B/8CBC2BpBjwWIR4bo69P4
         WIE0Joruz71FGhk7GrNhxudX0OdYZiY3T2nX4FoHFfQQNAVJpN2tMOK99w0MwPUmmCsG
         rNZQ==
X-Gm-Message-State: AFqh2kqi+Ab31eHqkYSiYR7/3jami79P8dxcr2xyQtngYUI3IU5Zh8OV
        LkZLhpi2nxVZcQiJ/+OwCvxIkyq54wo=
X-Google-Smtp-Source: AMrXdXuqIExoz1KdggK4V62mQTSd9Qhu9wNsHAolO6rFH/iSKHpqVVJol9SdetGRc261eg0JVANNoQ==
X-Received: by 2002:a05:6870:288a:b0:144:c094:16bb with SMTP id gy10-20020a056870288a00b00144c09416bbmr16293353oab.51.1674599252398;
        Tue, 24 Jan 2023 14:27:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ov16-20020a056870cb9000b00136f3e4bc29sm1288212oab.9.2023.01.24.14.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 14:27:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f8381a17-f4ca-122f-15fc-b5b88d3d322a@roeck-us.net>
Date:   Tue, 24 Jan 2023 14:27:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: linux-next: build failure after merge of the hwmon-staging tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mario Kicherer <dev@kicherer.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230125092416.44a98d6b@canb.auug.org.au>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230125092416.44a98d6b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yNC8yMyAxNDoyNCwgU3RlcGhlbiBSb3Rod2VsbCB3cm90ZToNCj4gSGkgYWxsLA0K
PiANCj4gQWZ0ZXIgbWVyZ2luZyB0aGUgaHdtb24tc3RhZ2luZyB0cmVlLCB0b2RheSdzIGxp
bnV4LW5leHQgYnVpbGQgKHg4Nl82NA0KPiBhbGxtb2Rjb25maWcpIGZhaWxlZCBsaWtlIHRo
aXM6DQo+IA0KPiBkcml2ZXJzL2h3bW9uL21jMzR2cjUwMDogc3RydWN0IG9mX2RldmljZV9p
ZCBpcyAyMDAgYnl0ZXMuICBUaGUgbGFzdCBvZiAxIGlzOg0KPiAweDAwIDB4MDAgMHgwMCAw
eDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAg
MHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAw
IDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgw
MCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4
MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAw
eDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4NmUgMHg3OCAweDcwIDB4MmMg
MHg2ZCAweDYzIDB4MzMgMHgzNCAweDc2IDB4NzIgMHgzNSAweDMwIDB4MzAgMHgwMCAweDAw
IDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgw
MCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4
MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAw
eDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAg
MHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAw
IDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgw
MCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4
MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAw
eDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAg
MHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAw
IDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHgw
MCAweDAwIDB4MDANCj4gRkFUQUw6IG1vZHBvc3Q6IGRyaXZlcnMvaHdtb24vbWMzNHZyNTAw
OiBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlzIG5vdCB0ZXJtaW5hdGVkIHdpdGggYSBOVUxMIGVu
dHJ5IQ0KPiANCj4gQ2F1c2VkIGJ5IGNvbW1pdA0KPiANCj4gICAgZDRhNmFlMDQ0MDQ1ICgi
aHdtb246IGFkZCBpbml0aWFsIE5YUCBNQzM0VlI1MDAgUE1JQyBtb25pdG9yaW5nIHN1cHBv
cnQiKQ0KPiANCj4gSSBoYXZlIHVzZWQgdGhlIGh3bW9uLXN0YWdpbmcgdHJlZSBmcm9tIG5l
eHQtMjAyMzAxMjQgZm9yIHRvZGF5Lg0KPiANCg0KQWxyZWFkeSBmaXhlZC4gU29ycnkgZm9y
IHRoZSB0cm91YmxlLg0KDQpHdWVudGVyDQoNCg==
