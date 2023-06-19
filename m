Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8BE735DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjFSTB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFSTBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:01:25 -0400
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4041A130;
        Mon, 19 Jun 2023 12:01:24 -0700 (PDT)
Date:   Mon, 19 Jun 2023 21:01:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
        s=202107; t=1687201282;
        bh=TlkLUt1Xc8aq5nLEbcCDsQIAUOAYxL+iBRdCpxuPfZI=;
        h=Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
         From:from:in-reply-to:in-reply-to:message-id:mime-version:
         references:reply-to:Sender:Subject:Subject:To:To;
        b=Xf5kKeyRTjyc8vlBQbKeRY2A8nWRWaaFF5QqrsswetHq82N2ILXlDdha5klJmt3O8
         D1xElotw/iUgI41Q/325DBF+/pR3zt9ejpheTlOem2XlN+hduYxabOR+VyrggMr7Qb
         7rV8ytrpdQvLEw5CzeVjgnwoIcUaRy7Q08KiGcZUcxkL8830Oj5OJIZY94ItpNqw4b
         YAMm+eEsTwYXK16HyN56O/bGNV6SR9hyJ+ZgyXud5QXPHOX0Ytfcjq63h2V6k3mEEP
         PdhrsGdqPOhL13HAtPZ0dXIRziuUBBuILE+tSwuF+JKf7MPA1eIuD5YPNYCn+fXQEP
         PbXflUUGJfRbg==
From:   Markus Reichelt <lkt+2023@mareichelt.com>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.3 000/187] 6.3.9-rc1 review
Message-ID: <20230619190122.GA3975@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230619102157.579823843@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
Organization: still stuck in reorganization mode
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.3.9 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.

Hi Greg

6.3.9-rc1

compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>
