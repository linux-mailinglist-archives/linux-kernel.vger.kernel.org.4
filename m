Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5926D1618
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 05:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCaDo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 23:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjCaDoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 23:44:21 -0400
Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C846EC76;
        Thu, 30 Mar 2023 20:44:20 -0700 (PDT)
Received: from eig-obgw-5015a.ext.cloudfilter.net ([10.0.29.155])
        by cmsmtp with ESMTP
        id i2BXpmmbjY6q8i5gZpCq8u; Fri, 31 Mar 2023 03:44:19 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id i5gYpYgnc8qini5gYpnonL; Fri, 31 Mar 2023 03:44:19 +0000
X-Authority-Analysis: v=2.4 cv=Y5frDzSN c=1 sm=1 tr=0 ts=64265713
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=k__wU0fu6RkA:10
 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8
 a=mvvmVGHGh8sE2eZWOBoA:9 a=QEXdDO2ut3YA:10 a=3IOs8h2EC4YA:10
 a=_FVE-zBwftR9WsbkzFJk:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5eXprcIlSCmNP0+hXkCotLeio81d6PPi52X+rolr6Bs=; b=x5tY3CALKqh0FtZknddMXTC50W
        m1K4lxEWe1p11l++HQJ+fNplppv50prQ5m2JM7gpVe5/SUGR1yw44c99RrLGNxMk4Bhc9LnxkSBkN
        yOIZcXiwHkNGQcJZxr7ZB4F/8Lfg+k9Eo50GRaqjYQcE8IeHWpt4Sl4nARkXwYCudsAPPbgsc+MD7
        KR20RZbQ0K303ZW0xyvhPT9lipNa93CjRo4gWhcLHPwb+nEqfJG4puxhGxVn130P5ODP3SLEWiXwP
        w8ZxTIh5Jv5DzrNlrcMY+qiPaVRsvtYGVqT7kpZR3qtlNTPJRJ5EighAursOyrapN8B8BsNsy7341
        nsCY6FBw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:36470 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1phydu-002oqq-Ra;
        Thu, 30 Mar 2023 15:13:06 -0500
Message-ID: <ef8d083a-a82b-669c-0b0a-959e0f120a26@embeddedor.com>
Date:   Thu, 30 Mar 2023 14:13:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH][next] drm/i915/uapi: Replace fake flex-array with
 flexible-array member
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZBSu2QsUJy31kjSE@work>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZBSu2QsUJy31kjSE@work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1phydu-002oqq-Ra
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:36470
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEv+S8oDVAlDw/SD2kuq8AKhKQROfPORYPUdQr6naFM90hgmY+HlEFbb89Kid0Seukx/L+WxIgdKTfN6eKdbea4tyG9FAAuEPq6qNV7RQce8VvqNqL5l
 SLufD/FYNuzsUnq9HfTaB8QFdujmpRnPYASl2YjO9jlGHu/C8pPV7xI+tE2En19THtJSXQuMLvcDzdpYfGwHgpzmkNZV4HZyeOJuiYh9PPaS9t6YQ3dzIfba
 aSo7OsLJqZFJEO625//RTCxD+EeYI0quZ5yIAWs4DZo=
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping: who can take this, please? 😄

Thanks
-- 
Gustavo

On 3/17/23 12:18, Gustavo A. R. Silva wrote:
> Zero-length arrays as fake flexible arrays are deprecated and we are
> moving towards adopting C99 flexible-array members instead.
> 
> Address the following warning found with GCC-13 and
> -fstrict-flex-arrays=3 enabled:
> drivers/gpu/drm/i915/gem/i915_gem_context.c: In function ‘set_proto_ctx_engines.isra’:
> drivers/gpu/drm/i915/gem/i915_gem_context.c:769:41: warning: array subscript n is outside array bounds of ‘struct i915_engine_class_instance[0]’ [-Warray-bounds=]
>    769 |                 if (copy_from_user(&ci, &user->engines[n], sizeof(ci))) {
>        |                                         ^~~~~~~~~~~~~~~~~
> ./include/uapi/drm/i915_drm.h:2494:43: note: while referencing ‘engines’
>   2494 |         struct i915_engine_class_instance engines[0];
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/271
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   include/uapi/drm/i915_drm.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
> index 8df261c5ab9b..5e458d6f2895 100644
> --- a/include/uapi/drm/i915_drm.h
> +++ b/include/uapi/drm/i915_drm.h
> @@ -2491,7 +2491,7 @@ struct i915_context_param_engines {
>   #define I915_CONTEXT_ENGINES_EXT_LOAD_BALANCE 0 /* see i915_context_engines_load_balance */
>   #define I915_CONTEXT_ENGINES_EXT_BOND 1 /* see i915_context_engines_bond */
>   #define I915_CONTEXT_ENGINES_EXT_PARALLEL_SUBMIT 2 /* see i915_context_engines_parallel_submit */
> -	struct i915_engine_class_instance engines[0];
> +	struct i915_engine_class_instance engines[];
>   } __attribute__((packed));
>   
>   #define I915_DEFINE_CONTEXT_PARAM_ENGINES(name__, N__) struct { \
