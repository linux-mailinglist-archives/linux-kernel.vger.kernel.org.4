Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DEC6E428B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjDQIZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDQIZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:25:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B2C2D73
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:25:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-504e232fe47so4656740a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681719944; x=1684311944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kvuR+wqBIrNMrDF8yas5oBzfAoNG26JbDTdN+RQDtGw=;
        b=DaJSuynxS/haARK9PTSpDSLYg59airZVDOBfgXmSmeteDKO+D8IpH/EzRdVDSvNuIk
         DwZNWNhX3L9irYaBz9Xon5MqgNIUb4kjEmbaYnXx3/3UfZe4QyFkDrcqYPOrKgvaP47G
         Gri9qX2xgHYtezDXRvffm3KXFbKbp9fpy25XxevbqkJSF56t8F2TSCQiXrIwt+8GCdzV
         FEZpSIBxhXkm3wbSmc5DYymvZnco7ckWL7yHuwZX28nkT+/0P9ZfttdGxaycAf94zoEF
         +n9kjh9ct32+ldkiAiOkRyhtQ7ZY7Rcvfnw7TR+ImPUYs7IPbfGoNhO7G2b+OIrkatMi
         cuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681719944; x=1684311944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvuR+wqBIrNMrDF8yas5oBzfAoNG26JbDTdN+RQDtGw=;
        b=SPFyfHHL2VyDPXqfh7ISjZpj/6TbWszKmsErtfyWDCPOUyRwFw0DHrL1dh6Yx7W1gL
         pn6pCSnZuNO6mRdQKjKPraCaUbj7DnrtXPxhh4FrrA+1SecMb5Gv06OduHdG94luf9ge
         5BLKes4xCC/+d+ALtq7gPaKuMSi6Ln6pLDb7DqJRAjjtbBNtOQ7A/2Gj/gxwdqpnEy5a
         ePbqTgqJpUovJFzvZEhOSgq45YQOHeG5tERzRhxjUamrzXvlzZ0KITHuRkdSL5CxHpi7
         C2A69QqKN0vYIPEenPZ2KA+OSBHn+9YGE+Lw5WaAsiiqYyWtCxDEi6dxqSlPckrrUH9i
         LoBw==
X-Gm-Message-State: AAQBX9dOeyDut+YZ/QV3anWTluejPWrwSk5aQ8+bOAhRzVjVrTaYJW3V
        oXTrlvUlr+TbDUXszpMs9j4=
X-Google-Smtp-Source: AKy350Zf+Dfcj30vv6PpXttbnXz/ncOUNytjrL8S4yP33+cxyVPefed+V98dsjjZRl8Eh2DL27odLg==
X-Received: by 2002:aa7:c2d4:0:b0:506:bdc:49c6 with SMTP id m20-20020aa7c2d4000000b005060bdc49c6mr13411195edp.23.1681719943805;
        Mon, 17 Apr 2023 01:25:43 -0700 (PDT)
Received: from kernelhacking.kernelhacking.example.com (dslb-088-067-245-126.088.067.pools.vodafone-ip.de. [88.67.245.126])
        by smtp.gmail.com with ESMTPSA id wy6-20020a170906fe0600b0094ee88207d5sm4573814ejb.191.2023.04.17.01.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 01:25:43 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:25:41 +0200
From:   Luke Koch <lu.ale.koch@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wlan-ng: replace rate macros
Message-ID: <ZD0ChREQnV8tKwS1@kernelhacking.kernelhacking.example.com>
References: <ZDqwZKZHyZZX4b2J@kernelhacking.kernelhacking.example.com>
 <f44f44e4-25c0-4489-96e9-8ca63fa294d7@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f44f44e4-25c0-4489-96e9-8ca63fa294d7@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 11:04:04AM +0300, Dan Carpenter wrote:
> On Sat, Apr 15, 2023 at 04:10:44PM +0200, Luke Koch wrote:
> > +	for (int i = 0; i < 8; i++) {
> > +		if (count > i &&
> > +		    DOT11_RATE5_ISBASIC_GET(item->supprates[i])) {
> > +			req->basicrate[i] .data = item->supprates[i];
>                                          ^
> Could you remove these spaces before the .data and .status?  Otherwise
> it looks good to me.

Sure, the spaces must have been leftovers from the token pasting and I
unfortunately overlooked them. Thanks for reviewing!

Best regards,
Luke Koch
