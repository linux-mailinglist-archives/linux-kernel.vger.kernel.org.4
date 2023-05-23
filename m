Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5C670E37D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbjEWRXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbjEWRXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:23:20 -0400
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54149E49;
        Tue, 23 May 2023 10:22:57 -0700 (PDT)
Date:   Tue, 23 May 2023 19:22:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
        s=202107; t=1684862557;
        bh=q19IHGegy619Nos+P6JqxqIxNFqZBK2vqe5G1jDonAE=;
        h=Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
         From:from:in-reply-to:in-reply-to:message-id:mime-version:
         references:reply-to:Sender:Subject:Subject:To:To;
        b=TZHH88rMFLbGG7c7Zzz0nR1ZcjCRmvNqcT4B+tgw104F9ALlsvq2xR5AhJ2Zs4kLW
         0f163hbAgm6IhAhSNUJu1qGgyFEOifWfeMj8OVShTcYeoF8mpmU1CBV/u5GtAdz+jb
         J7ZBLnvfWAg5ic1A3zO7ELkdekcCAW4D3reH84/TuU2UcRQDyb3nxirV4hB+8v3PBp
         h+6z7CNo1TESY26++ANvUKsnUbUIV8uld0TX3bgD17D9+iwBTU2VCN4o7lE4UL0aAN
         B6naiXH4g2eG8JziUh9Xau49NPp9HY12zgjr3FfO0JnMw/GuCe1L/g4XnBSzs7stWo
         /mcPoiDYfvNYA==
From:   Markus Reichelt <lkt+2023@mareichelt.com>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.3 000/364] 6.3.4-rc1 review
Message-ID: <20230523172237.GB4058@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230522190412.801391872@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
Organization: still stuck in reorganization mode
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.3.4 release.
> There are 364 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.

Hi Greg

6.3.4-rc1

compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>
