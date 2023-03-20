Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070946C0C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjCTIuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjCTIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:50:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A320FA264;
        Mon, 20 Mar 2023 01:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=I2Jl3JT8J1uJjpTjaCxXjzNckeeoraJU6znCrVmqum8=;
        t=1679302250; x=1680511850; b=v99Z71EgDbcGdHJvzex4PW3ZX+v1cBnLumCA5dwLKxM6EAG
        3mObe211qGb7d0yhiCZBqL3vTGTHrSsaqyvXf6K4HebwTY6CyYrU1k2hlPyn03+ZGGoP165x7LPfy
        SuFVsT5JLr+1d1q+AQANbUNpG3jOivnsDtf8ZdU7GsPSknJVhIus2YK/erwITl3kBVDTfLstLgjGU
        lKllqmYK2admeZJ3mJb3jMvE+N6WU6r/oLP0JWBEqVHU3/jDT2Z5ELYH2QEeUfNNayzQykJsj61ij
        0okU5YulrXQxU2QZiNrW2TW8tFuUwUo2IKCEKZ52mbm4k1P48RbNPZTNYS/o5kBQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1peBDw-008u1U-2K;
        Mon, 20 Mar 2023 09:50:36 +0100
Message-ID: <7cd746c7b585c5086cfbd9db22414a060356cdd8.camel@sipsolutions.net>
Subject: Re: [PATCH 2/4] bitfield: Introduce the FIELD_MODIFY() macro
From:   Johannes Berg <johannes@sipsolutions.net>
To:     William Breathitt Gray <william.gray@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 20 Mar 2023 09:50:35 +0100
In-Reply-To: <1c1492558c1a72b64bb26f7a44c4e69fff0e6b44.1679149543.git.william.gray@linaro.org>
References: <cover.1679149542.git.william.gray@linaro.org>
         <1c1492558c1a72b64bb26f7a44c4e69fff0e6b44.1679149543.git.william.gray@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-03-18 at 14:59 +0000, William Breathitt Gray wrote:
> It is a common code pattern to modify a bitfield by masking the field
> and performing a bitwise OR with the respective FIELD_PREP. Wrap such a
> task into a macro by introducing FIELD_MODIFY() which modifies the field
> specified by a mask from a bitfield by putting a val in the field.

So I have no objection to adding this and you using FIELD_* macros, but
just wanted to say that personally I've come to prefer the typed
versions declared later in the fiel, and there we have
<type>_replace_bits() already.

Hmm. And now that I mentioned that, maybe that means FIELD_REPLACE()
would be nicer as a name?

johannes

