Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC606DCCB4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjDJVSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDJVSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:18:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04B0E60;
        Mon, 10 Apr 2023 14:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1681161502; i=w_armin@gmx.de;
        bh=1lyPPUjpdGEhnPbZRwfiDYpPJ0jzSO8k05yn4ts4q7E=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=BtznYG+0Khz1qDlfsEifq61thGm5EvncCVzJm2ODRrKzstjU2jadmWD0hAzeKzG54
         f24zxkt+FYbXTEeswk+6Y4JXkjHvuyUnoZylphzJhUq0cHnFq+/JHvLBJwvDc7FPJ+
         o6ga51Lc6JpT2syxccaJHm0RXVjaSKKNS5x/Mb/kV4Aoz7gWKejMdIY4nEGWAtubEI
         i/UMHfDTxl99I/xvwvQTnkFj/B8mtDE1CcLFOtdlwc4g6z25jVWa7AwwTBkv3X8gsn
         +GAwwWtNt/7epKWHRYDEjigYLh1RTLVmEQOaiIBJHV8oUDSdv3zTfwJrEDIlFf9Ps+
         4qM8H1SiB/WFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbg4-1q4bBK2PnQ-00KwTH; Mon, 10
 Apr 2023 23:18:22 +0200
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Armin Wolf <W_Armin@gmx.de>
Subject: ACPI EC SMBus driver
Message-ID: <6d5bdf77-a507-dfe1-6d92-3602638711ce@gmx.de>
Date:   Mon, 10 Apr 2023 23:18:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:zHoYvZz+FSNrDpHb8uDLXdsXU0igc+KDigWEpHYgLKihk2U2s7/
 YoScRYNmWyn3hwARMfzvKAVEdoy8K22id7HtYgy/pL/3mUyN8fxQH4dqSWZOcsSO5/PmjZi
 2o9sAXEOsM0HEBtrjYHVWAzLF3jHQl2Y5R1xiSQM5x1Cei0fZxzCp/NbOLSVoW2jzYpv783
 WW9HbhLo3Apn68RzNDrCA==
UI-OutboundReport: notjunk:1;M01:P0:dWf88fORlEQ=;tx+epeIAd7pXKVXZwbkjk37B9jo
 RAuhvehKxiDDDa849nFRSrXQjw9vYlPd+8WSoVS+j9aiQRhTjGPPVeDMnsBqGoxhIoV58SdUV
 zj0vH7fnuvI7GGX1nFmsz8IMpoPNdkO+JCU4n0FJCR/o36zSMVm3s80X24O9eNGhbXY7MRhA4
 Yz+vBrN9vGgVHWUuf6ZwSWexNKMwa5P4lwVi8Hq7YoqFZZbUsBZSyHaN4c0EyPPQ0W7DEiFK0
 UJ9OI38JWHzgDi17eqK109j/2fPkaBaxD3RgLF6PoVO8TtFNHSUcXJdKfCgHfhjyx8+mlK9Qq
 rwpFbqBkDDjxAu+8uEx6lCK1dxr8ptGTiejzxkInvIhXyWaZ72nTMe3ikNFmUAr/xFc0sQEqp
 E7phsZVPXqO3qjcUhbGosN1t42Xn6p3UZMVuO92BRxWs29dtR9ger3zHfh1kHhX1X22m8V5LC
 tDhLU9nIYgIOxn/tapAY1onbBtLuxrVBUBL4EoqwUYkohUlwdc1sHH0GDP0Czz+cIYP1B6V1B
 Z9/qLRpW2/bochU10q306O4op5AIcPuH3nPkcbntgIxmvrysjVFZFlVC5+knUV6cDpRV7uGfL
 vfnn2S3BfFgzC9nsA1uUSr4ekG1u/L1ScnoefDBZN9DAw6P/bRss1K7Cj9ZGKRB6UItpInt35
 aLObgORew84W0VZHHrpJVMVcrTsMr/6wNaBEVuf/7JRvcdZqk+9BoaIgxbg8qgMkxPzJBh37B
 ySHQYS51Nhjp4AGUdEbGj+VnaE+lXiov8amRjCxGtHFgujz6mPT0fKGIRTygK1tbbKPfnXsiZ
 aIBRLA/lUC5juKrd4GkZcg6F3KP6ot+b48LUkVpQuwz20hogliYdA+pZ/nrtrlfABayJOQ0iv
 T32E4udu7RCd9nYglBOyEqt+qO9adVw6eNuZx3Wnh4HlqD2AIagmI7JmE0w2fgxUikQEBAW6v
 mBsCV7uqcDlYRGQ+JOvQPG9c4L4=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i am currently trying to develop a full-featured i2c bus driver for ACPI EC SMBus controllers.
Currently, those are handled by the "sbshc" driver, which unfortunately does not register a i2c
bus driver. This would allow for replacing the outdated "sbs" and "sbshc" drivers with the standard
"sbs-battery", "sbs-manager", ... i2c drivers. Also, ACPI SMBus OpRegions for ACPI EC SMBus could
finally be supported.

While doing this, i stumbled upon a possible issue: the ACPI EC is accessed using ec_read(), which
could cause problems if multiple ACPI EC are present. This could be solved by somehow exposing
acpi_ec_read()/_write().

I am currently thinking of two options for doing this:
- expose them as-is and use dev->parent private drvdata (fragile)
- create a separate ec.h like this to hide internal driver details:

#ifndef __ACPI_EC_H
#define __ACPI_EC_H

void *acpi_get_parent_ec_cookie(struct acpi_device *adev);

int acpi_ec_read(void *cookie, u8 address, u8 *data);
int acpi_ec_write(void *cookie, u8 address, u8 data);

int acpi_ec_add_query_handler(void *cookie, u8 query, (void)(callback)(void *id), void *id);
void acpi_ec_remove_query_handler(void *cookie, u8 query, void *id);

#endif

Which one should i choose for developing the ACPI EC SMBus driver?

Thanks,
Armin Wolf

