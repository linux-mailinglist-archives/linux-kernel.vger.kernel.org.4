Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E226F98F7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjEGOkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjEGOkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:40:17 -0400
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7903D13C28
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 07:40:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683470415; x=1683477615; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=RreZAVcyefedcZBaVH9BWSwdNdF4YJTlkaVu3S0N8c0=;
 b=GWhIzn/QadVE+9rBLxPT3BTwUvG8bdcn5TEAk6syEQFuW0n2OVLiavMRqKZPs6dDa6f2Hs6Ec2nymLA5JQ1XF+A8NGbIBcTNAzWFYAR3HD4+t01ymbfeABIkmdYEAfMkDO/N6/qNPegy+/PTrgoGQ/QgmF8fAQMOzFEtSw+JHNKA4W3MmgSAGCfigbhn6S4JpASuE5ZLFbuV+cFtg1CIaPDAXIHKNt7NyrtOkjGYXqhISBRU5BD5eIH6W3xZwpjeoh/FmV7LjIGFXtN+ZmdY/8cGpSp327hGdPRZfDzW7WpJv1uwlmXHEGafxGChHjAV1wMELuefEHjrjTSuZadqPg==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 4ea46d00a2ee with SMTP id
 6457b84f2ce85fdbb9469639 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 07 May 2023 14:40:15 GMT
Sender: james@equiv.tech
Date:   Sun, 7 May 2023 07:40:13 -0700
From:   James Seo <james@equiv.tech>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 04/11] Documentation/hwmon: Revise hwmon kernel API
 reference
Message-ID: <ZFe4TfGAcuIfXUiO@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-5-james@equiv.tech>
 <512351f8-e571-620a-1b2b-54989c079803@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <512351f8-e571-620a-1b2b-54989c079803@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 06:52:09AM -0700, Guenter Roeck wrote:
> There is a lot of nnecessary churn in your patches, where you reformat entire
> paragrahps just to add a few "``". This makes it almost impossible to identify
> the actual changes. For me it means that the review burden is so much that I'll
> probably never get to actually review those changes.
> 
> Please split the changes into subjects, following the "one logical change per
> patch" rule, and please refrain from changing entire paragraphs when adding
> markups. Also, a reference to the markup rules explaining if and when markups
> are warranted would be nice. For example, I have no idea why "hwmon" would
> warrant a markup.
> 
> Guenter
>

Ack. Thanks for this. It's the sort of feedback I was hoping to receive
by submitting as an RFC series.

James
