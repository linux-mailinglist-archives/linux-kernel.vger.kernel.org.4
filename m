Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28DB6618D4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 20:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjAHTvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 14:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjAHTvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:51:02 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C42D102
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 11:51:01 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id cf42so9960579lfb.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 11:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profian-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aU2zr2iZRkwdiLRZc2HQ0PPfl5aKsrDvsWOmQ2ZkJHg=;
        b=l8FngI+xGJZlNcTM9+XmMERicEgz/5P3iHfWvWkMRn6LZssTgmJ5JRoi5JWQ/L1hFo
         AFXrvzTfnw4f/mp7K0uidlDpjw8gPohaXp3K3fLcrDLsaYEIUg2fD7TXh0EK9KE0xdqj
         ziUIaWWE4spaz4hriq1Rj3+eZyCLs1uHQHVoOyX9LbAzJyQo22pKMh9H6xjX1tlXwDmw
         NnvsH0lkEBb7vN1I5brydC6WheZYLSHjK524qAd9nCaliS0qlPtVefJiqT6GpZrT7Kzh
         T56tLkYuh0onrcXgmR/azzCeQeQaLnSDHi6gJ9a4h1cbH+qPCs6DoD++7a3Uj8CkaSOt
         6ZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU2zr2iZRkwdiLRZc2HQ0PPfl5aKsrDvsWOmQ2ZkJHg=;
        b=FbAFnEcKtuUSFJ7vLq/U6h5iwHuTV+MSTcREvhnHetjUWzDZgQcEcXNor6FQKlvXOW
         se9U/S2yQ3xT5ugmxXhy0E1H4A78T1jQKzpnorFYBzLUDzgjpxyEN1qJrrvrUGdGL00+
         OdAqbGDJ0xnVEVvaw2UKCcCqzEEYWsaKIGOiuajYbOg1w8PO0m0632La2mmaCEsR0A7j
         nHur2eu4YhgX/z8OnWuVbMP3fohlTZf0SExOo21j36f/EFB4JjzylchDNwYLSAeLuYBS
         YwUpKvonV4zS+Uy3KCx2X98H4qEPY7porH76EszGQ6yrzIJY6wB5FPLOq1lmblrNS6uw
         l5CQ==
X-Gm-Message-State: AFqh2koJQl4gIcI0eQ/yUcvEiEIlQXzzxjIZizOaQLCxM7GPeE1n8Dar
        Jmfs+CcY9UMLsFZo2OAifK3m7A==
X-Google-Smtp-Source: AMrXdXuRHLdXdNlP7oB+NQEBE/FcVjlDNWgmLu8baXnF3TfOWniqnR4Uz8byWcOB2WEHJt4MHG7fEg==
X-Received: by 2002:ac2:48a5:0:b0:4b6:ed1d:38e9 with SMTP id u5-20020ac248a5000000b004b6ed1d38e9mr17209222lfg.64.1673207459424;
        Sun, 08 Jan 2023 11:50:59 -0800 (PST)
Received: from localhost ([85.202.81.211])
        by smtp.gmail.com with ESMTPSA id s11-20020a056512314b00b004b592043413sm1202685lfi.12.2023.01.08.11.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 11:50:58 -0800 (PST)
Date:   Sun, 8 Jan 2023 19:50:56 +0000
From:   Jarkko Sakkinen <jarkko@profian.com>
To:     David Rientjes <rientjes@google.com>
Cc:     linux-crypto@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ccp: Improve sev_platform_init() error messages
Message-ID: <Y7seoGQpTy6LYQZU@profian.com>
References: <20221231151106.143121-1-jarkko@profian.com>
 <6a16bbe4-4281-fb28-78c4-4ec44c8aa679@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a16bbe4-4281-fb28-78c4-4ec44c8aa679@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2023 at 07:18:30PM -0800, David Rientjes wrote:
> On Sat, 31 Dec 2022, Jarkko Sakkinen wrote:
> 
> > The following functions end up calling sev_platform_init() or
> > __sev_platform_init_locked():
> > 
> > * sev_guest_init()
> > * sev_ioctl_do_pek_csr
> > * sev_ioctl_do_pdh_export()
> > * sev_ioctl_do_pek_import()
> > * sev_ioctl_do_pek_pdh_gen()
> > * sev_pci_init()
> > 
> > However, only sev_pci_init() prints out the failed command error code, and
> > even there the error message does not specify, SEV which command failed.
> > 
> > Address this by printing out the SEV command errors inside
> > __sev_platform_init_locked(), and differentiate between DF_FLUSH, INIT and
> > INIT_EX commands.
> > 
> > This extra information is particularly useful if firmware loading and/or
> > initialization is going to be made more robust, e.g. by allowing
> > firmware loading to be postponed.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
> > ---
> >  drivers/crypto/ccp/sev-dev.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> > index 5350eacaba3a..ac7385c12091 100644
> > --- a/drivers/crypto/ccp/sev-dev.c
> > +++ b/drivers/crypto/ccp/sev-dev.c
> > @@ -963,6 +963,7 @@ static int __sev_init_ex_locked(int *error)
> >  
> >  static int __sev_platform_init_locked(int *error)
> >  {
> > +	const char *cmd = sev_init_ex_buffer ? "SEV_CMD_INIT_EX" : "SEV_CMD_INIT";
> >  	struct psp_device *psp = psp_master;
> >  	struct sev_device *sev;
> >  	int rc = 0, psp_ret = -1;
> 
> I think this can just be handled directly in the dev_err() since it's only 
> used once.

Ack.

> > @@ -1008,18 +1009,23 @@ static int __sev_platform_init_locked(int *error)
> >  	if (error)
> >  		*error = psp_ret;
> >  
> > -	if (rc)
> > +	if (rc) {
> > +		dev_err(sev->dev, "SEV: %s failed error %#x", cmd, psp_ret);
> >  		return rc;
> > +	}
> >  
> >  	sev->state = SEV_STATE_INIT;
> >  
> >  	/* Prepare for first SEV guest launch after INIT */
> >  	wbinvd_on_all_cpus();
> > -	rc = __sev_do_cmd_locked(SEV_CMD_DF_FLUSH, NULL, error);
> > -	if (rc)
> > -		return rc;
> > +	rc = __sev_do_cmd_locked(SEV_CMD_DF_FLUSH, NULL, &psp_ret);
> > +	if (error)
> > +		*error = psp_ret;
> >  
> > -	dev_dbg(sev->dev, "SEV firmware initialized\n");
> 
> Any reason to remove this dbg line?  I assume the following dev_info() 
> line is deemed sufficient?

Yes, but agreed that it is not in the scope of the patch so I'll remove
it from the next version.

> 
> > +	if (rc) {
> > +		dev_err(sev->dev, "SEV: SEV_CMD_DF_FLUSH failed error %#x", psp_ret);
> > +		return rc;
> > +	}
> >  
> >  	dev_info(sev->dev, "SEV API:%d.%d build:%d\n", sev->api_major,
> >  		 sev->api_minor, sev->build);
> > @@ -2354,8 +2360,7 @@ void sev_pci_init(void)
> >  	/* Initialize the platform */
> >  	rc = sev_platform_init(&error);
> >  	if (rc)
> > -		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
> > -			error, rc);
> > +		dev_err(sev->dev, "SEV: failed to INIT rc %d\n", rc);
> >  
> >  skip_legacy:
> >  	dev_info(sev->dev, "SEV%s API:%d.%d build:%d\n", sev->snp_initialized ?

Thank you for the feedback.

BR, Jarkko
