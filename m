Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDFB704382
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjEPCkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEPCkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:40:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49055B8;
        Mon, 15 May 2023 19:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ojBki+nmxNg7b/giD8lLnQpVmamD8lFgMekCY08c6Ys=; b=JFPfq+AjJqSF/FJN7EtOzAN3RY
        ba9GPnuk0brYK+fjsG9qKwYwzrmdX47DboG0JQFP5PZlVN/mml+gC8NxmW+NW9ddA3IQ6iKVaiWqZ
        wo/CMUajQYyrfpl8aJsk+7WRGsEk7NaPL8YTfFi2p7lNhsJwXZsXr+H5xsekTTSuC5T+wLw8NEvmS
        hsvzLf5zsG9vwjIZ4cjc2bowyZyR9yYRNF0zBtt2CQh2dAGTLiOttj9rBgto5N89KLib3bXpK/7RQ
        YAGWgbA81CfQWEoGR86C5i0a6H+Vow7GkWaifhJ4aREhjJhQNbR28PIT63g9SZn6SJTSKDLSlxOQg
        fIWvlH/w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pykba-0049z5-2s;
        Tue, 16 May 2023 02:40:02 +0000
Message-ID: <db4d4826-93ad-d5c7-372a-82818b1ebe9a@infradead.org>
Date:   Mon, 15 May 2023 19:40:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: linux-next: Tree for May 15 (drivers/tty/serial/8250/8250_omap.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>
References: <20230515141235.0777c631@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230515141235.0777c631@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/23 21:12, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230512:
> 

# CONFIG_PM is not set


../drivers/tty/serial/8250/8250_omap.c:169:13: warning: 'uart_write' defined but not used [-Wunused-function]
  169 | static void uart_write(struct omap8250_priv *priv, u32 reg, u32 val)
      |             ^~~~~~~~~~


-- 
~Randy
