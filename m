Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E746F8429
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjEENf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjEENfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:35:22 -0400
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C9A21559
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:35:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683293717; x=1683300917; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=DD2z3LiP3xw4vE6DWZRwCLdem0fFOzkDm2X/pdLJWl0=;
 b=NcgAukgFrFAiSx1k8J/pi/TSGSslV88uOs/CqLe9Ym7KfnU7IdJTjpMWbARaBhEDXxCi2WhlU2K8pGWVY7xZ6KFWJYD0hOh5hGh3Fx1r760NziSYctqAYNl5qHKVq1mjrlNcixwNpIXEyEK0s4kS1eRzw1fBMPjg2lXLxHJsdMiYsE6UIga0zHYW/UztC4a/bLwl6skzYLvd8GZ0axA4ogKP98P+PwhQFJCCRY6f/QRcnLgDiBFxeBCKUffLUxOt03RG9d5gSynMy78q5mHB1PoC/iO9rm51SyoGGxqzqVKXag25cmLIpmXK4uMjywA0cN0gfBqC5bgNHEwXcxJQuQ==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 70825b0c4f46 with SMTP id
 645506155e23e5f95b9f3ec2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 May 2023 13:35:17 GMT
Sender: james@equiv.tech
Date:   Fri, 5 May 2023 06:35:16 -0700
From:   James Seo <james@equiv.tech>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 05/11] Documentation/hwmon: Revise PMBus core documentation
Message-ID: <ZFUGFHzV1KmNPtFo@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-6-james@equiv.tech>
 <ZFSFzaWZsS9qxmzz@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFSFzaWZsS9qxmzz@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 11:27:57AM +0700, Bagas Sanjaya wrote:
> 
> Seems like a candidate for attribution:
> 
> ---- >8 ----
> diff --git a/Documentation/hwmon/pmbus-core.rst b/Documentation/hwmon/pmbus-core.rst
> index 2f88a03446d2be..75404f088fd777 100644
> --- a/Documentation/hwmon/pmbus-core.rst
> +++ b/Documentation/hwmon/pmbus-core.rst
> @@ -21,7 +21,7 @@ Introduction
>    with the objective to provide support to, and facilitate adoption among,
>    users.
>  
> -    (from pmbus.org)
> +  -- (from pmbus.org)

Will do.

>  
>  Unfortunately, while PMBus commands are standardized, there are no mandatory
>  commands, and manufacturers can add as many non-standard commands as they like.
> 
> Otherwise the formatting LGTM, thanks!
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> -- 
> An old man doll... just what I always wanted! - Clara
