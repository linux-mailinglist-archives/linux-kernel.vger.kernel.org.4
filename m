Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7200772E77F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242573AbjFMPkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243034AbjFMPkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:40:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7553819B6;
        Tue, 13 Jun 2023 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=2SJDWDPhp0gjXKO83sRx30AxnfsPbJ+TkvDdczAUaQw=; b=Oquei1SzdLbi2O5mcqwSutVp2j
        gjN0clYhJNLxNP6AUsoZfSQtRr1hEpOv/RK5AU+U+LwsD+zx1Ykma7KlsLiETRk5wYp0q05GObM7K
        zN0N4Qk0K6fQ2A64kU6kmuwix/HCvS0Mw6NI7IzDpfJi0EWQbQvVUoblLjxd8pI2m/qtzvpcoeSjr
        BbvKT6bKeNstFkpRO2F3J0/dadfEUPIQPlpt1b/KRbrwqjM2km/VUpNg53kpfJYXJMh6/0JHepwLv
        LR7fBTwOLpL/5wdeey+YxaFINMO3bzbUWV+K9mizYcJUmMatXdROJ04ca+6VhyiXHLtcw2QLr2S74
        VwwLHNrw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q967U-008V3j-2b;
        Tue, 13 Jun 2023 15:39:44 +0000
Message-ID: <89adc1ac-25a0-6eb6-4cc9-ab6cc8d49730@infradead.org>
Date:   Tue, 13 Jun 2023 08:39:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: linux-next: Tree for Jun 13 (drivers/gpu/drm/i915/display/)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org
References: <20230613165903.5cc10e58@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230613165903.5cc10e58@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/23 23:59, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230609:
> 

In file included from <command-line>:
./../drivers/gpu/drm/i915/display/intel_display_power.h:255:70: error: 'struct seq_file' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
  255 | void intel_display_power_debug(struct drm_i915_private *i915, struct seq_file *m);
      |                                                                      ^~~~~~~~
cc1: all warnings being treated as errors
In file included from ./../drivers/gpu/drm/i915/display/intel_display_power_well.h:10,
                 from <command-line>:
./../drivers/gpu/drm/i915/display/intel_display_power.h:255:70: error: 'struct seq_file' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
  255 | void intel_display_power_debug(struct drm_i915_private *i915, struct seq_file *m);
      |                                                                      ^~~~~~~~
cc1: all warnings being treated as errors


-- 
~Randy
