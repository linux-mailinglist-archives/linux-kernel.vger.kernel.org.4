Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85EF73A238
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjFVNys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjFVNyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:54:46 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF5A118;
        Thu, 22 Jun 2023 06:54:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666e3b15370so4244516b3a.0;
        Thu, 22 Jun 2023 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687442085; x=1690034085;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9uei6ikJRas22Hwp4mZTaUlT0qL8iBQnmHCBvfcXwE=;
        b=Kw978Z23e+L9swbJ/qPhWDxzJV/G86Wx25DJn0cTKvNiYACrmzp7BPZctuPoub+e7A
         SzHfOnzp5yXISP7WfuVH7apwXlXoU8dBq93wopAFKfrK5PVe5ABShZf4FdHPVkf0G/5o
         oUto5fvdibM432uwNFHFOLEQuBPwhbRg5i/mBJQ/KO5gRMtcXB8nuNoNjx66SQoEjU5a
         qbvyJUojUiTFgAn3KuQ72WAr12vm3uPfSN57MMrQLtBsvX0b2Ao5XzzTJhV9gCwAqTaZ
         TdI7VmpmMdYjeY+FaqUxH/p8idBD432Qz3d9XcrxyTFIPn14OQGqUpU4mfg8+YmvwVt6
         M6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687442085; x=1690034085;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9uei6ikJRas22Hwp4mZTaUlT0qL8iBQnmHCBvfcXwE=;
        b=MrwfljWi+uDOTdgueB7tiSZ+aR3M7dE9X7NEe3E42KGzN6Kp1/f3+bzkVepf/yo0Pt
         t9eaUFWitU87/C6EaqQVrvan0xY8l9XJMRfL9tJBZqeJl1bYkPR1bdQlBYslKa2zCfnE
         ca/VQQIkkqyBDNSF9ABq+r4sgv2rFMvQi/Xp5rlkO2IaH3om5cmqTlVPDr1nehRCe4Xg
         tIGjk7oK0mAPkgu/BEZpU5M5i9iTf+8/e32R72X3yLYotSO/rdXumq17S+MPSqhgu0Yn
         6sE/ONwMyG7SmN4YJW9zEWbKeDWH+mGKRNK4VMEUkyzSUKnVeDc8ze/mWHV066/Qju/1
         sJuQ==
X-Gm-Message-State: AC+VfDzYfhs5DrhT4SDorB7TfJ/BKH0gKmG7GcFoQMIlURa1HpEguw/B
        zP0J768rDf9S0FcErZMybuU=
X-Google-Smtp-Source: ACHHUZ4VL42ePsHWyAuI2cunIMNJN+2l9+MrvWkXvb25dMA29+z9x10vrON9kyt3JVkzTTwIqmP7Hw==
X-Received: by 2002:a05:6a00:b83:b0:668:6eed:7c1b with SMTP id g3-20020a056a000b8300b006686eed7c1bmr15157991pfj.14.1687442084782;
        Thu, 22 Jun 2023 06:54:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n4-20020a635904000000b00553b9e0510esm4778946pgb.60.2023.06.22.06.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 06:54:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8e6c8365-5c2b-2bad-bf3c-df2d65cc8afa@roeck-us.net>
Date:   Thu, 22 Jun 2023 06:54:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230523074535.249802-1-hch@lst.de>
 <20230523074535.249802-15-hch@lst.de>
 <8c1992bc-110a-4dad-8643-766c14bf6fd4@roeck-us.net>
 <20230622035149.GA4667@lst.de>
 <2205ef1e-9bb6-fb1e-9ca3-367c1afe12ac@roeck-us.net>
 <20230622060001.GA8351@lst.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 14/24] init: clear root_wait on all invalid root= strings
In-Reply-To: <20230622060001.GA8351@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 23:00, Christoph Hellwig wrote:
> Hi Guenter,
> 
> can you try this patch?
> 
> diff --git a/block/early-lookup.c b/block/early-lookup.c
> index a5be3c68ed079c..66e4514d671179 100644
> --- a/block/early-lookup.c
> +++ b/block/early-lookup.c
> @@ -174,7 +174,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
>   	while (p > s && isdigit(p[-1]))
>   		p--;
>   	if (p == s || !*p || *p == '0')
> -		return -EINVAL;
> +		return -ENODEV;
>   
>   	/* try disk name without <part number> */
>   	part = simple_strtoul(p, NULL, 10);

Not completely. Tests with root=/dev/sda still fail.

"name" passed to devt_from_devname() is "sda".

        for (p = s; *p; p++) {
                 if (*p == '/')
                         *p = '!';
         }

advances 'p' to the end of the string.

         while (p > s && isdigit(p[-1]))
		p--;

moves it back to point to the first digit (if there is one).

         if (p == s || !*p || *p == '0')
		return -EINVAL;

then fails because *p is 0. In other words, the function only accepts
drive names with digits at the end (and the first digit must not be '0').

I don't recall how I hit the other condition earlier. I have various
"/dev/mmcblkX" in my tests, where X can be any number including 0.
Maybe those fail randomly as well.

Overall I am not sure though what an "invalid" devicename is supposed
to be in this context. I have "sda", "sr0", "vda", "mtdblkX",
"nvme0n1", "mmcblkX", and "hda". Why would any of those not be eligible
for "rootwait" ?

In practice, everything not ending with a digit, or ending with
'0', fails the first test. Everything ending with a digit > 0
fails the second test. But "humptydump3p4" passes all those tests.

Guenter

---
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

#define EINVAL1	1
#define EINVAL2	2
#define EINVAL3	3
#define ENODEV	4

static int devt_from_devname(const char *name)
{
         int part;
         char s[32];
         char *p;

         if (strlen(name) > 31)
                 return EINVAL1;

         strcpy(s, name);
         for (p = s; *p; p++) {
                 if (*p == '/')
                         *p = '!';
         }

         /*
          * Try non-existent, but valid partition, which may only exist after
          * opening the device, like partitioned md devices.
          */
         while (p > s && isdigit(p[-1]))
                 p--;
         if (p == s || !*p || *p == '0') {
                 return EINVAL2;
         }

         /* try disk name without <part number> */
         part = strtoul(p, NULL, 10);
         *p = '\0';

         /* try disk name without p<part number> */
         if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p') {
                 return EINVAL3;
         }
         return ENODEV;
}

char *devnames[] = {
     "sda",
     "sda1",
     "mmcblk0",
     "mmcblk1",
     "mtdblk0",
     "mtdblk1",
     "vda",
     "hda",
     "nvme0n1",
     "sr0",
     "sr1",
     "humptydump3p4",
     NULL
};

int main(int argc, char **argv)
{
	char *str;
	int i;

	for (i = 0, str = devnames[0]; str; str = devnames[++i]) {
	    printf("%s: %d\n", str, devt_from_devname(str));
	}
}

