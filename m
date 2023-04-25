Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263736EE19C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjDYMG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjDYMG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:06:27 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80573AA9;
        Tue, 25 Apr 2023 05:06:21 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 568171AFC;
        Tue, 25 Apr 2023 14:06:19 +0200 (CEST)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1682424376; x=1684238777; bh=1quTiAqVzsZGhgLkkRVbglXHFhLg3FUJ99F
        n/BliYRU=; b=nJKedt0dV1ma7iwyLMYLzlGN8s0LqMGVyCbFURjHRpprhBVxQrI
        IJtd44HC/MXPkQVbgm/owXS38tIHBDeip9KB0Hubj9gF2oqghW3yAz/ES6dn8sTj
        TeI76x6ukdb5oDHv2CRHP2iuBq6cSKNom9MW0XKvT10RYil2po2RxYulcFxqxfac
        KxL0Ensq43asxcEO8be4Xrja/7I47AqUb7h1S6+n4RXiJwC+9FkcHPxgqWK5n4Rr
        Xcn8qc+038smmL/arnFcLKGPnapshoziaAP84LUneMGxQynEegDoapQnqk/o7t5r
        j1F4AZ0LHImwCtOzbZX7NGMvaiGzdDky7OZKvnmNq7NZWzOi+1s1uJIXAbE7qatB
        XQdzk2VgtphEloCz9sVoaGSQYkSnWfcK39rgDXhOrMUuZrUjnTFjkCv14GF1FT6/
        nf7YtZuItQQ2Vqg8PW2yi4CUKR/i6g/LXHczxE/rm+jsmVf1PCZiTHrTyJJsNJTG
        IVdOFx3jPz0VBoUJoChdc7oiBMvoHRewwmF7+gyD35ZJX1h6PB1QUelw6Uz1quJK
        D1ALsgXpDlRISAbCAjgRYIMPxGs/fgWBPBxA6VcY7o6Okyodt8J2cqYPL9rfaMBr
        CMlPK3TE2/EQKot914La3FDRsUVX6XrzKGPi2kGmXLAExOxSyl8ZhEeA=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q0RLDHaGpSLY; Tue, 25 Apr 2023 14:06:16 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by mx.kolabnow.com (Postfix) with ESMTPS id 5D45116A7;
        Tue, 25 Apr 2023 14:06:15 +0200 (CEST)
Received: from int-subm001.mykolab.com (unknown [10.9.37.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 83128DD5;
        Tue, 25 Apr 2023 14:06:14 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Apr 2023 14:06:13 +0200
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Fabio Fantoni <fantonifabio@tiscali.it>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: fix some typos
In-Reply-To: <20230425110158.9755-1-fantonifabio@tiscali.it>
References: <20230425110158.9755-1-fantonifabio@tiscali.it>
Message-ID: <91b1a96e1bfcdbe0ea47bcd2aa268989@vaga.pv.it>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-25 13:01, Fabio Fantoni wrote:
> Fix of some typos spotted reading documentation in italian and latest
> changes for 6.4
> 
> Signed-off-by: Fabio Fantoni <fantonifabio@tiscali.it>

Reviewed-by: Federico Vaga <federico.vaga@vaga.pv.it>

Thanks Fabio for the fixes.

> ---
>  Documentation/translations/it_IT/kernel-hacking/locking.rst | 2 +-
>  Documentation/translations/it_IT/process/deprecated.rst     | 2 +-
>  .../translations/it_IT/process/submitting-patches.rst       | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
