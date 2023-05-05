Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488946F840B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjEEN3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjEEN3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:29:20 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8932CE72
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:29:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683293358; x=1683300558; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=aO9K7NPvdxrmC7vIMAsNBMR6TnQRDey4237WbWDA7Gs=;
 b=mUz36zLYO4r7gqamR1EJ+UJuScQfvp84RsuZQ5VaVR32hz1G2ZuZSi91A1P6ObDsTGmplLZ5Pr0chJGDMJm1RLY3txN1MeDxzM4hCTYLlU3DOyw2GRAsUZ5D65p9Ty5Y4ETtAN9ojnsUNgt1co7kFVAiSRxGXZLNBZ0V1uD6lDr2gwmQOggCmBWYAI6v/oM+DYjSWGE0KO5YGJ/M+9sTjiZuN8GSyXtWtgxRincKKgnXjY4L+A/kQVSrNlta0YgerARO+hXfd6RJN9r33WLSFkFJlYrT4OPEPtMYFy+6WqCONTH0uVkRuCNKJ9lzCB0ydUzoX641YK/VTgBk/AQ72Q==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 242c85f0262a with SMTP id
 645504ae3cb0b25455ddf089 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 May 2023 13:29:18 GMT
Sender: james@equiv.tech
Date:   Fri, 5 May 2023 06:29:17 -0700
From:   James Seo <james@equiv.tech>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 04/11] Documentation/hwmon: Revise hwmon kernel API
 reference
Message-ID: <ZFUErfFIalIFEtlu@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-5-james@equiv.tech>
 <ZFSEIahcPf2QUYDv@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFSEIahcPf2QUYDv@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 11:20:49AM +0700, Bagas Sanjaya wrote:
> 
> I forget to mention this.
> 
> Elsewhere in the doc tree (Documentation/), metadata is usually marked
> up like:
> 
> ---- >8 ----
> diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
> index cf084e04052228..541835f7826352 100644
> --- a/Documentation/hwmon/hwmon-kernel-api.rst
> +++ b/Documentation/hwmon/hwmon-kernel-api.rst
> @@ -2,7 +2,7 @@
>  The Linux Hardware Monitoring kernel API
>  ========================================
>  
> -Guenter Roeck
> +:Author: Guenter Roeck
>  
>  .. contents::
>  
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara
Hi,

Thanks for reviewing.

I will add the :Author: tag to this document.

James

