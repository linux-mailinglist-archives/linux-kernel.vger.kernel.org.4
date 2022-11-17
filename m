Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABEE62DE11
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbiKQO1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbiKQO1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:27:17 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B776379E1C;
        Thu, 17 Nov 2022 06:27:16 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id k15so1935402pfg.2;
        Thu, 17 Nov 2022 06:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MuPgpre3wzn5WJZUlqLPK4/VfBG9+9DDaXxDqH0YfTg=;
        b=gDrkj1lVR4IK0kfw/npxyZUbUD2NZG/OGlcfnkWxLkgYEFb7H9Q44NG9P/eKZVCRwy
         0AqPixB5lzjkrxJ3Tvemmb32exJNXXMaUfqmNPd+pS6qNQmVL/9KPo3l97hnNjAxEk1O
         ArenFxGlmUYLJW6Xb+oCKHz76UB9OV5SaguCLg7sw2h5AYKN4vncA/euRp4ZbDdK8a94
         3q6JUUf1s9ejeo59lUs0/Elc1nmbjzHfof/IopD2wfsscm9srbbRuwG8U4jbLkPA4QOv
         n9RZM0l1pgrBOwrs4yaSCeb11kaNUPzSyAJTbU2E1nUfw3nxmQXX9W1FXtelewruH4yY
         JpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuPgpre3wzn5WJZUlqLPK4/VfBG9+9DDaXxDqH0YfTg=;
        b=RXiI5ED/LwcsjBGI+raSsHG7VMnSzVFm/1KDoEzo0ezoPmuRbTUoHNz7lKVsYUStV7
         3VZvXqyvWAExQLLFfV34MNINDwpw1CUJqIAj3YKmUnvBRUcdckYs3RYm49hc3DQMCKIK
         3E6+ao+S9XM7LGmiwYEz8Bbofi8EUA3KkU1Pj4Po17R4Ip1wZVZkAx48k5wwXG699S63
         0Mji1ryWy0ADY/hs/EyCAeubTJXlvb3fAbFcI9HVO4AqKWlgT/k5ilQV1KCJYIRlN00z
         DODdX9s3aaX+cHXV1HzrwJnGiGx4rCngxxRME8KSKgwbLXdbG9/hLdAdgCwdVlPoTPja
         T3Cg==
X-Gm-Message-State: ANoB5pkDQ0ftq3qWrKX+vhmUoDsYO0N3kIM3y9215A+1akdosYQx9tRC
        kWufMNc2eGlMaxjz0HXkMo4=
X-Google-Smtp-Source: AA0mqf5j440VkxQLEn4vGPnBkUjnZGHiKjxcKqHgkmTySQfsUCazaibRjFLcAv3i9cDadAoIGIpVgA==
X-Received: by 2002:a63:e008:0:b0:46f:5979:8889 with SMTP id e8-20020a63e008000000b0046f59798889mr2339672pgh.119.1668695236195;
        Thu, 17 Nov 2022 06:27:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902b68500b00186b758c9fasm1448385pls.33.2022.11.17.06.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 06:27:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 17 Nov 2022 06:27:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ninad Malwade <nmalwade@nvidia.com>
Cc:     treding@nvidia.com, jonathanh@nvidia.com, jdelvare@suse.com,
        nicolinc@nvidia.com, rkasirajan@nvidia.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina3221): tighten attribute sysfs permissions
Message-ID: <20221117142714.GB664755@roeck-us.net>
References: <20221117083920.20493-1-nmalwade@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117083920.20493-1-nmalwade@nvidia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:39:20PM +0800, Ninad Malwade wrote:
> The INA3221 device provides voltage and current measurements for
> various power rails, including the CPU rail, on at least some Jetson
> boards. This raises the possibility of the Platypus attack being relevant
> to Jetson. To prevent this possibility, modify all attribute
> channel permissions so that only root can access the values.

NACK. The hwmon ABI expects all attributes to be readable for everyone.
Forcing userspace to have root privilege to read sensor values just moves
the attack vector into the affected applications.

You have a number of options:

1) Make the values reported vague enough to be useless for attacks
2) Remove the attributes
3) Remove the driver

2) and 3) are obviously unacceptable here. Your option would be to
disable the driver on the affected system.

Having said that, for me to accept any driver change, you would have to
prove that the values reported by the chip are really accurate enough to
be useful in any attack (most chips do not deliver that level of accuracy).
A generic statement along the line of "raises the possibility" is
insufficient.

> This is logically equivalent to 949dd0104c49 ("powercap: restrict energy
> meter to root access") upstream.
 
The change in the powercap driver is not hwmon ABI related and
irrelevant. If you look for an example, use commit 9049572fb145
("hwmon: Remove amd_energy driver").

Guenter
