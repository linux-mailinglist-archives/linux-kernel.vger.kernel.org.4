Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E32615B62
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 05:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiKBEWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 00:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKBEWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 00:22:20 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00514008;
        Tue,  1 Nov 2022 21:22:18 -0700 (PDT)
Received: from [192.168.43.182] (unknown [62.168.35.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A5748431C4;
        Wed,  2 Nov 2022 04:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667362936;
        bh=FwVCtFn/dnSNoKOJUkgIAOFezIthumprUKIfhV70keg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=vE85L7X7o3L+iFP416R06kq7gOla4E5Rz8/PCCEj4c1Ve5AwlFuDKFjTl1z5D60wW
         nUuawqOoP1jqlhNQPJjRtG4FiIMSyXSr3Jwh1QsTwN5AE6J+/oa97q6iRCxH3Xbhjp
         bBeveo1YxxbxT0eBtKRysmi/Pt2JpwW2jVDt3E6CCGvH3WGMYHcll8bJPlTBjDwauA
         qV0jq/8/bMsMUCZbiCZVlMvbl1obUE87kWLaFX5Yahe9cJ7/lIsyNfCHZHqDUaS/Cd
         THbv7dKjDr3HlZoenqWvYYTVebWBhtP/k7HvMo6OFrDvamCLZ94wXgG9O7uLGj4JBD
         kgS+zPYnwqzdA==
Message-ID: <ab30aa6b-126c-67b9-c578-3564444769fd@canonical.com>
Date:   Tue, 1 Nov 2022 21:22:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: linux-next: Signed-off-by missing for commit in the apparmor tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221102082826.0541eec6@canb.auug.org.au>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221102082826.0541eec6@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/22 14:28, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>    0fc0401eb24c ("apparmor: Add __init annotation to aa_{setup/teardown}_dfa_engine()")
> 
> is missing a Signed-off-by from its committer.
> 
sorry fixed. Looks like my pre-push hook needs a fix

