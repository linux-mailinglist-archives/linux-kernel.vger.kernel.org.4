Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815706ABFF6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjCFMzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjCFMz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:55:29 -0500
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Mar 2023 04:55:26 PST
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DA72B630;
        Mon,  6 Mar 2023 04:55:26 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 0C66440DA3;
        Mon,  6 Mar 2023 13:35:57 +0100 (CET)
Authentication-Results: ext-mx-out003.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1678106154; x=1679920555; bh=CldnAGWCUyLWQj0+FhFTF/gQQirraazid4l
        4YVTfOJ8=; b=w9T3IV/Ww8mnjjLPqOmY3uJru3lYyOeSk+w/VcE55YQ2u9fVOfh
        MUkvZppkRlu3OT43tqcS1s3ZI8zXZI8B1CuFHGwAwuASJvstpOPu0E9NlB8Z5pmJ
        R+Fc53gtNu6pJ+phAmn+6flLW1TjUzFT+IKiWNSNwusKGanqAFoQxa9er6JFYdPi
        6rYt5yadVSfVgsILAgiqYVBGu/lvz8BwhhSbqrkeVfIMUK7tcwGubnLizLPlLpZZ
        9rAe4fxDL9yX4A52Won7+F6ajcZrnjlhquIe21HXpeb2oSMMGBELciIrdf4Zp6xT
        SLEpn3BTohYZzSrMxbcR5UDiMmD1IE9RyY3w70G4itvS14p4acW341WIqaQTYY6U
        VjeiFxWTbbHk0G1hl+SGCES+zhqcut5dVOwwk/Bpt+nxx0JHrNyPSQnK0zt9jGvL
        l0SLY0GK4ElzwFeEcuJTi4xRMUDlQjyyGmT70NOdDuFk+bIUBGw3m1NWkYthsrkX
        9syZ8yFdxWkyA+2YFqHkLHcmgmHheltrtVHt2bCkihfbhmhmbrPdtq9rX97t6PMW
        vSpCZbNfzX05WmGlskHzeJESFCcVyE3GgsCJORS6lwC2up3ir644d/s8TDpg4GLo
        gZiUmXSFWd30FOIh9dR8aizZqW0j7n33CW48/y1122us2EjY3BoC8PFM=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xPYFZXUyIZwT; Mon,  6 Mar 2023 13:35:54 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by mx.kolabnow.com (Postfix) with ESMTPS id 0450A404DB;
        Mon,  6 Mar 2023 13:35:32 +0100 (CET)
Received: from int-subm001.mykolab.com (unknown [10.9.37.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id C755C8AB;
        Mon,  6 Mar 2023 13:35:31 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 06 Mar 2023 13:35:29 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Solar Designer <solar@openwall.com>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jiri Kosina <jikos@kernel.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Tsugikazu Shibata <tshibata@ab.jp.nec.com>,
        Minchan Kim <minchan@kernel.org>,
        Jeimi Lee <jamee.lee@samsung.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v3 1/7] Documentation/security-bugs: move from
 admin-guide/ to process/
In-Reply-To: <20230305220010.20895-2-vegard.nossum@oracle.com>
References: <20230305220010.20895-1-vegard.nossum@oracle.com>
 <20230305220010.20895-2-vegard.nossum@oracle.com>
Message-ID: <b435d859273cc51efb3e0284ba3c9a7e@vaga.pv.it>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-05 23:00, Vegard Nossum wrote:
> Jiri Kosina, Jonathan Corbet, and Willy Tarreau all expressed a desire
> to move this document under process/.
> 
> Create a new section for security issues in the index and group it with
> embargoed-hardware-issues.
> 
> I'm doing this at the start of the series to make all the subsequent
> changes show up in 'git blame'.
> 
> Existing references were updated using:
> 
>   git grep -l security-bugs ':!Documentation/translations/' | xargs
> sed -i 's|admin-guide/security-bugs|process/security-bugs|g'
>   git grep -l security-bugs Documentation/translations/ | xargs sed -i
> 's|Documentation/admin-guide/security-bugs|Documentation/process/security-bugs|g'
>   git grep -l security-bugs Documentation/translations/ | xargs sed -i
> '/Original:/s|\.\./admin-guide/security-bugs|\.\./process/security-bugs|g'
> 
> Notably, the page is not moved in the translations (due to my lack of
> knowledge of these languages), but the translations have been updated
> to point to the new location of the original document where these
> references exist.

Fine with me (Italian), I will move it later to the right place to 
reflect
the English version

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>

> diff --git
> a/Documentation/translations/it_IT/admin-guide/security-bugs.rst
> b/Documentation/translations/it_IT/admin-guide/security-bugs.rst
> index 18a5822c7d9a..20994f4bfa31 100644
> --- a/Documentation/translations/it_IT/admin-guide/security-bugs.rst
> +++ b/Documentation/translations/it_IT/admin-guide/security-bugs.rst
> @@ -1,6 +1,6 @@
>  .. include:: ../disclaimer-ita.rst
> 
> -:Original: :ref:`Documentation/admin-guide/security-bugs.rst 
> <securitybugs>`
> +:Original: :ref:`Documentation/process/security-bugs.rst 
> <securitybugs>`
> 
>  .. _it_securitybugs:
> 
> diff --git
> a/Documentation/translations/it_IT/process/submitting-patches.rst
> b/Documentation/translations/it_IT/process/submitting-patches.rst
> index c2cfa0948b2b..167fce813032 100644
> --- a/Documentation/translations/it_IT/process/submitting-patches.rst
> +++ b/Documentation/translations/it_IT/process/submitting-patches.rst
> @@ -272,7 +272,7 @@ embargo potrebbe essere preso in considerazione
> per dare il tempo alle
>  distribuzioni di prendere la patch e renderla disponibile ai loro 
> utenti;
>  in questo caso, ovviamente, la patch non dovrebbe essere inviata su 
> alcuna
>  lista di discussione pubblica. Leggete anche
> -Documentation/admin-guide/security-bugs.rst.
> +Documentation/process/security-bugs.rst.
> 
>  Patch che correggono bachi importanti su un kernel già rilasciato, 
> dovrebbero
>  essere inviate ai manutentori dei kernel stabili aggiungendo la 
> seguente riga::

-- 
Federico Vaga
