Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578D16F852F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjEEPBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjEEPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:01:17 -0400
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F100C17DDC
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 08:01:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683298874; x=1683306074; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=j5Y8/YxWyoZ+TMXH031Qq4b+VwVzb7sYuIJBdbFKn+o=;
 b=gYULfPiSnaSbmWO016+m17diIzAsGJzr5ZjdflDbdDm9Ruo0Ks/KeYBcc4deN4V4pdse7UbDxiMcR66xXJy1N1LeZbXOBt6EXwS5uW+cPlON6a0/UNsA/XIxWY/D67UlfjlZbO9yL5YDThTyah5a2aRL4dFJHGj6UKiCAwsbeZcHgXrMK/Y9pQjL0Cs8dGYxDc9fOyfMxFK5KfKjdO/Xn9JNzJGbhIauzGQpdHLpZrgA/9pRE2hxmX2SAtlhrOzKizZOtWpu18+suM9Ooxt6h1nBx1HpbKmtYXCHkiUZxEo2oS8ZYy5RCTS9s6Us66EmGQhoWpCaWQlsQHBxYCYSRw==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by e393140286f2 with SMTP id
 64551a365e23e5f95b516f98 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 May 2023 15:01:10 GMT
Sender: james@equiv.tech
Date:   Fri, 5 May 2023 08:01:09 -0700
From:   James Seo <james@equiv.tech>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 07/11] Documentation/hwmon: Revise sysfs interface
 specification
Message-ID: <ZFUaNQAxjvnFnsOr@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-8-james@equiv.tech>
 <ZFSLN6KmGgfW4YzE@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFSLN6KmGgfW4YzE@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 11:51:03AM +0700, Bagas Sanjaya wrote:
> On Thu, May 04, 2023 at 12:57:48AM -0700, James Seo wrote:
>> +**RO**    Read-only value.
>> +**WO**    Write-only value.
>> +**RW**    Read/write value.
> 
> Why are the permissions be emphasized?

I don't remember, to be honest. I will deemphasize permissions.

> 
>> +| | ``pwm[1-*]_auto_point[1-*]_pwm``        | **RW** | PWM temperature curve definition    |
>> +| | ``pwm[1-*]_auto_point[1-*]_temp``       |        | for chips that associate trip       |
>> +| | ``pwm[1-*]_auto_point[1-*]_temp_hyst``  |        | points with PWM output channels.    |
>> ++-------------------------------------------+--------+-------------------------------------+
>> +| | ``temp[1-*]_auto_point[1-*]_pwm``       | **RW** | PWM temperature curve definition    |
>> +| | ``temp[1-*]_auto_point[1-*]_temp``      |        | for chips that associate trip       |
>> +| | ``temp[1-*]_auto_point[1-*]_temp_hyst`` |        | points with temperature channels.   |
> 
> Dunno if replacing line blocks with bullet lists should improve the semantic
> of three sysfs files having the same description.
> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara

These are line blocks, not bullet lists. They ensure that each
attribute name is on its own line, avoiding strange wrapping like:

  pwm[1-*]_auto_point[1-*]_pwm pwm[1-*]_auto
  _point[1-*]_temp pwm[1-*]_auto_point[1-*]_temp_hyst

