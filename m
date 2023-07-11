Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B670C74F4F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGKQTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjGKQTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:19:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77701704;
        Tue, 11 Jul 2023 09:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65A8361562;
        Tue, 11 Jul 2023 16:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C07EC433C7;
        Tue, 11 Jul 2023 16:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689092303;
        bh=H+sDqiglxa90HZqqkinNdJS6RR3oeOZptSHzXAiYaZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q/EJAHvkvCxH8K3zYpmHJQibelUtbSaI98TdbDGqhH0TceqglP/VbxVUZxGfOvCRS
         lLtMTktx+DIua0+RKTc4QURukV1qEf347LJQPsv6l8UBoXo1TjIsi24EPa8whzPi+J
         sH3j/4+r0zKJFLWILteYzrjRrQgdMFfFN+GEMf6oVo53j/X/ji09rICHxKeAj0V34a
         ehnszcIbj5MH3memsgJJIe2r6Ovi9NygE228y5eDCy1Ovgz891GeOd7r63g9lQOfQL
         STiwBDlXbP/E00HdxpKefh0Lc+m0jt9FmCprCm/lJKkzMYRmawZBaWQAbjZK3ujVVr
         yheVm2XGdy/EA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BEBCA40516; Tue, 11 Jul 2023 13:18:20 -0300 (-03)
Date:   Tue, 11 Jul 2023 13:18:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        jolsa@kernel.org, rostedt@goodmis.org, svens@linux.ibm.com,
        gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH v2] perf/build: fix broken dependency check for libtracefs
Message-ID: <ZK2AzMwrsLVPMnuq@kernel.org>
References: <20230711135338.397473-1-tmricht@linux.ibm.com>
 <ZK2AISIWZX5GlOZv@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK2AISIWZX5GlOZv@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 11, 2023 at 01:15:29PM -0300, Arnaldo Carvalho de Melo escreveu:
 
> Applied to perf-tools, for v6.5.

I also changed the subject line to add that this was caused by a change
in the external library, it is reading like this in my local repo:

  perf build: Fix broken feature check for libtracefs due to external lib changes

- Arnaldo
