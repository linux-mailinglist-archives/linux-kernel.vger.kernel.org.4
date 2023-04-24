Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A9B6ED038
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjDXOVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXOVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:21:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9AF61B6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:21:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F8FA1FD87;
        Mon, 24 Apr 2023 14:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682346102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oS59SRMyvblbYQ/G1blmGCgsVR/u0O42HYVoCKNaGwc=;
        b=Vil/LZpKUEtewmntDHG7Yrp7JFnWc5IuxrclIFUDBS1KwY7XjqmGVqbH67axq3RIiSLLFe
        Ak/ScVmBdalNEUSVeSpa73lqzNe88hAstKIeIK45RZa7WhmTPffSUqwtEPj7nj44mpe/3d
        GMKAhSgJlnysgDC00vxd+mSmnK4JxyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682346102;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oS59SRMyvblbYQ/G1blmGCgsVR/u0O42HYVoCKNaGwc=;
        b=i1h6J7pBqXJZarnZ05WykCJwXV+6MX8LtYRm3kGbFNgu6wOg+ue9c+BbaTdok743txiH/q
        wzN3B0axDhgKifDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 129F81390E;
        Mon, 24 Apr 2023 14:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7pRcA3aQRmQ2PAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 24 Apr 2023 14:21:42 +0000
Message-ID: <8315a507-3f27-5b08-7d0c-c6056b64c3d6@suse.cz>
Date:   Mon, 24 Apr 2023 16:21:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH linux-next v2] mm: workingset: update description of the
 source file
Content-Language: en-US
To:     Yang Yang <yang.yang29@zte.com.cn>, akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, rppt@kernel.org
References: <0ddb50f0-2e2d-e750-3867-3842a3ea12cc@suse.cz>
 <20230421113130.240586-1-yang.yang29@zte.com.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230421113130.240586-1-yang.yang29@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/23 13:31, Yang Yang wrote:
>> I'm late but FWIW, not supper happy that while the updated calculations are
>> now accurate wrt the actual code, the explanation (which was written at the
>> time of page cache-only workinset) was more easier to follow in the simpler
>> form. Now it's still mostly talking about page cache and explaining the
>>balance between its active and inactive list only, and then suddenly the
>> anon lists appear out of nowhere in the final equations.
> 
> Thanks for your reviewing! I should update the whole parts. Sorry for
> hadn't do it better, please drop the patch, I will try to submit patchv3
> to fix this.

I think it's too late to drop, and not worth rebasing the git tree in early
merge window for that.

>> In other words, I think it would have been better to leave that explanation
>> as it was, and then add a new part describing the extension to anon pages.
> 
> I read the description of the source file again carefully, and think that
> there is no need to creat a new part, if we explain at the begining that
> the word 'pages' include page cache and anonymous page, and do some minor 
> adjustments. For example:
> Per node, two kinds of clock lists are maintained for pages..

I think it would make following the explanation more complicated, and it's
already difficult enough. Reasoning just about active vs inactive file list
is much simpler to follow the equations and observations behind them. Wonder
what Johannes as the original author thinks, anyway.
