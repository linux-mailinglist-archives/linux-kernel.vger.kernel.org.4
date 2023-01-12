Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC9A668571
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbjALVcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbjALVbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:31:51 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C1D36339;
        Thu, 12 Jan 2023 13:15:37 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.230]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MybbH-1oXIxD33rJ-00yxhc; Thu, 12 Jan 2023 22:14:50 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id C44983C1B9; Thu, 12 Jan 2023 22:14:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1673558085; bh=ueaZ7qRmhwgL5Koba7sENAXlFnsBTsko001t+9SMGpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k4h/OuWEs9Km9rDpXkHnguFfrg87t6dAhMK0sBSMw2aVL6jI5VwcwFplpsbyWAgpw
         mpXrdzSyrwNa747F+H2ngHcXqJCLld9UwmAYyWBdyqrD8FimavMmaL1izdf/ZBBYJh
         X7bvQN5JcbLLfPwkN9u9NnrIWrjrkUGg839Kr3eQ=
Date:   Thu, 12 Jan 2023 22:14:44 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Subject: Re: [PATCH] scripts: handle BrokenPipeError for python scripts
Message-ID: <Y8B4RJBg6FWuL1UL@fjasle.eu>
References: <20230112023006.1873859-1-masahiroy@kernel.org>
 <CAKwvOd=k=veNG=Q-bZxX4iX4q14e2ozO_sHZhdCz1+BwBxq=cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ESul6TuRCN2yDNb"
Content-Disposition: inline
In-Reply-To: <CAKwvOd=k=veNG=Q-bZxX4iX4q14e2ozO_sHZhdCz1+BwBxq=cQ@mail.gmail.com>
X-Provags-ID: V03:K1:0K7CqpWuSLqQclTR+kYZFUVmdYLjOFXqVF252IaUJDxOLJet7Kf
 IQQ1jHo96wKJXbaZyifPDR6IB24eVYs1EW1yH66jhuuIuXkXT5fzJEz9zUneTZFF5ltCKuH
 4de8+CVUJ0lnkYH0kmk/Ub+MC1NhThB0gqCaQtunncJvmbiNoqI/18k0piVT4YcgW4kqLx0
 WJIOpEr25xXugnyCtQf1w==
UI-OutboundReport: notjunk:1;M01:P0:5cqQc5QMkeU=;CwxenqyaT0BVmvZjbrEgCKDUumk
 jyTuK1iSVksPd7Dn35PgxhuVU9bpSMdyBeYbZVuCqibZOxLtl0fuztkDKadBDIrSGb+fmnrBI
 XwHe+dBGwK/DzR40meSxVPxkECrgIkvBEjC8CThbR9bcspT7/adXksz+l2J5qk2RawiJseBL6
 Ax6V/hU6a1mhJ9efc6eunkxYZD6BmEsgvKF7mzYRCkANHmZv4jzx8SxyOLcz2Nf7cd7C/4E0W
 P2ROJS02X8UwRQvXvmlcubslQcoO67irr2HX4yQGr7IClLmxg6HVs3S9j836Iq4Z+Pg6XH4gh
 rUKWkp5W/CGANZ0I5SFP3WevHDjqd4vMxFQxEFW36iaJM/aQYq0iScUEnW5lumV1+twysDx9z
 nQWmaPOjZGXZZ3A2IlDkV3gPNwRTpQism9nNxq9rXh5OA9/kTsaBxj+iXXnbfvcioEBwHTR35
 ZuEtXjmSrwLVVKE7LFrY669raqzdz9pogH1yq7RKHxN3jvl3tiNH/DpoMUIhSPbzUoIK8Xqjf
 8cfkyQNfUXXF6EU9D4MH3w3p+hnup3h40j9AmpAKQWXS8KEpcvj2uIzqYdkQACuHbtTh9YyZi
 Q0RCSl1VPR5RO+rRjeavIhXoaBwt//87nyo1ShL6o5+Vl9pwAAec+bgnSSJxLPHMOx+wxzCNZ
 s3P0YAWrPpuVpX2OYfOl/BxhbUdwzsbfI0Kv8eLRiw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ESul6TuRCN2yDNb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2023 at 10:55:45AM -0800 Nick Desaulniers wrote:
> On Wed, Jan 11, 2023 at 6:30 PM Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
> >
> > In the follow-up of commit fb3041d61f68 ("kbuild: fix SIGPIPE error
> > message for AR=3Dgcc-ar and AR=3Dllvm-ar"), Kees Cook pointed out that
> > tools should _not_ catch their own SIGPIPEs [1] [2].
> >
> > Based on his feedback, LLVM was fixed [3].
> >
> > However, Python's default behavior is to show noisy bracktrace when
> > SIGPIPE is sent. So, scripts written in Python are basically in the
> > same situation as the buggy llvm tools.
> >
> > Example:
> >
> >   $ make -s allnoconfig
> >   $ make -s allmodconfig
> >   $ scripts/diffconfig .config.old .config | head -n1
> >   -ALIX n
> >   Traceback (most recent call last):
> >     File "/home/masahiro/linux/scripts/diffconfig", line 132, in <modul=
e>
> >       main()
> >     File "/home/masahiro/linux/scripts/diffconfig", line 130, in main
> >       print_config("+", config, None, b[config])
> >     File "/home/masahiro/linux/scripts/diffconfig", line 64, in print_c=
onfig
> >       print("+%s %s" % (config, new_value))
> >   BrokenPipeError: [Errno 32] Broken pipe
> >
> > Python documentatin [4] notes how to make scripts die immediately and
>=20
> typo: s/documentatin/documentation/
>=20
> > silently:
> >
> >   """
> >   Piping output of your program to tools like head(1) will cause a
> >   SIGPIPE signal to be sent to your process when the receiver of its
> >   standard output closes early. This results in an exception like
> >   BrokenPipeError: [Errno 32] Broken pipe. To handle this case,
> >   wrap your entry point to catch this exception as follows:
> >
> >     import os
> >     import sys
> >
> >     def main():
> >         try:
> >             # simulate large output (your code replaces this loop)
> >             for x in range(10000):
> >                 print("y")
> >             # flush output here to force SIGPIPE to be triggered
> >             # while inside this try block.
> >             sys.stdout.flush()
> >         except BrokenPipeError:
> >             # Python flushes standard streams on exit; redirect remaini=
ng output
> >             # to devnull to avoid another BrokenPipeError at shutdown
> >             devnull =3D os.open(os.devnull, os.O_WRONLY)
> >             os.dup2(devnull, sys.stdout.fileno())
> >             sys.exit(1)  # Python exits with error code 1 on EPIPE
> >
> >     if __name__ =3D=3D '__main__':
> >         main()
> >
> >   Do not set SIGPIPE=E2=80=99s disposition to SIG_DFL in order to avoid
> >   BrokenPipeError. Doing that would cause your program to exit
> >   unexpectedly whenever any socket connection is interrupted while
> >   your program is still writing to it.
> >   """
> >
> > Currently, tools/perf/scripts/python/intel-pt-events.py seems the

Hi Masahiro,

should it be "... seems to be the ..."? =20

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> > only script that fixes the issue that way.
> >
> > tools/perf/scripts/python/compaction-times.py uses another approach
> > signal.signal(signal.SIGPIPE, signal.SIG_DFL) but the Python
> > documentation clearly says "Don't do it".
> >
> > I cannot fix all Python scripts since there are so many.
> > I fixed some in the scripts/ directory.
>=20
> That's ok; "Rome wasn't built in a day." This is a good start!
> Thank you for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>=20
> >
> > [1]: https://lore.kernel.org/all/202211161056.1B9611A@keescook/
> > [2]: https://github.com/llvm/llvm-project/issues/59037
> > [3]: https://github.com/llvm/llvm-project/commit/4787efa38066adb51e2c04=
9499d25b3610c0877b
> > [4]: https://docs.python.org/3/library/signal.html#note-on-sigpipe
> >
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/checkkconfigsymbols.py         | 13 ++++++++++++-
> >  scripts/clang-tools/run-clang-tools.py | 21 ++++++++++++++-------
> >  scripts/diffconfig                     | 16 ++++++++++++++--
> >  3 files changed, 40 insertions(+), 10 deletions(-)
> >
> > diff --git a/scripts/checkkconfigsymbols.py b/scripts/checkkconfigsymbo=
ls.py
> > index 217d21abc86e..36c920e71313 100755
> > --- a/scripts/checkkconfigsymbols.py
> > +++ b/scripts/checkkconfigsymbols.py
> > @@ -115,7 +115,7 @@ def parse_options():
> >      return args
> >
> >
> > -def main():
> > +def print_undefined_symbols():
> >      """Main function of this module."""
> >      args =3D parse_options()
> >
> > @@ -467,5 +467,16 @@ def parse_kconfig_file(kfile):
> >      return defined, references
> >
> >
> > +def main():
> > +    try:
> > +        print_undefined_symbols()
> > +    except BrokenPipeError:
> > +        # Python flushes standard streams on exit; redirect remaining =
output
> > +        # to devnull to avoid another BrokenPipeError at shutdown
> > +        devnull =3D os.open(os.devnull, os.O_WRONLY)
> > +        os.dup2(devnull, sys.stdout.fileno())
> > +        sys.exit(1)  # Python exits with error code 1 on EPIPE
> > +
> > +
> >  if __name__ =3D=3D "__main__":
> >      main()
> > diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-too=
ls/run-clang-tools.py
> > index 56f2ec8f0f40..3266708a8658 100755
> > --- a/scripts/clang-tools/run-clang-tools.py
> > +++ b/scripts/clang-tools/run-clang-tools.py
> > @@ -61,14 +61,21 @@ def run_analysis(entry):
> >
> >
> >  def main():
> > -    args =3D parse_arguments()
> > +    try:
> > +        args =3D parse_arguments()
> >
> > -    lock =3D multiprocessing.Lock()
> > -    pool =3D multiprocessing.Pool(initializer=3Dinit, initargs=3D(lock=
, args))
> > -    # Read JSON data into the datastore variable
> > -    with open(args.path, "r") as f:
> > -        datastore =3D json.load(f)
> > -        pool.map(run_analysis, datastore)
> > +        lock =3D multiprocessing.Lock()
> > +        pool =3D multiprocessing.Pool(initializer=3Dinit, initargs=3D(=
lock, args))
> > +        # Read JSON data into the datastore variable
> > +        with open(args.path, "r") as f:
> > +            datastore =3D json.load(f)
> > +            pool.map(run_analysis, datastore)
> > +    except BrokenPipeError:
> > +        # Python flushes standard streams on exit; redirect remaining =
output
> > +        # to devnull to avoid another BrokenPipeError at shutdown
> > +        devnull =3D os.open(os.devnull, os.O_WRONLY)
> > +        os.dup2(devnull, sys.stdout.fileno())
> > +        sys.exit(1)  # Python exits with error code 1 on EPIPE
> >
> >
> >  if __name__ =3D=3D "__main__":
> > diff --git a/scripts/diffconfig b/scripts/diffconfig
> > index d5da5fa05d1d..43f0f3d273ae 100755
> > --- a/scripts/diffconfig
> > +++ b/scripts/diffconfig
> > @@ -65,7 +65,7 @@ def print_config(op, config, value, new_value):
> >          else:
> >              print(" %s %s -> %s" % (config, value, new_value))
> >
> > -def main():
> > +def show_diff():
> >      global merge_style
> >
> >      # parse command line args
> > @@ -129,4 +129,16 @@ def main():
> >      for config in new:
> >          print_config("+", config, None, b[config])
> >
> > -main()
> > +def main():
> > +    try:
> > +        show_diff()
> > +    except BrokenPipeError:
> > +        # Python flushes standard streams on exit; redirect remaining =
output
> > +        # to devnull to avoid another BrokenPipeError at shutdown
> > +        devnull =3D os.open(os.devnull, os.O_WRONLY)
> > +        os.dup2(devnull, sys.stdout.fileno())
> > +        sys.exit(1)  # Python exits with error code 1 on EPIPE
> > +
> > +
> > +if __name__ =3D=3D '__main__':
> > +    main()
> > --
> > 2.34.1
> >
>=20
>=20
> --=20
> Thanks,
> ~Nick Desaulniers


--7ESul6TuRCN2yDNb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmPAeEMACgkQB1IKcBYm
EmlO1Q/8D91AJiaysQV1sTZSYys92zoVSAW1yR+rr7ugnr1AWXspaS2qYKX39ppf
Ur77qOaVuhW2s3eT+NO9JaVxL1va4/Y3KEklp+tQygoyz1C09TUih6XbR/YH7En0
uk5oWVLNOSQ8p+2BxOsxEuP8VDYe4s42J4QsR2vgV/9GhuD9RAX37HhCSwkoQFwP
ROP8mq4bFazar/uzod8r4e3b7F0eGOoRnAQkG+KwB7m5fLxrV/1faKW6JikEZIkN
U3B4rMqzIYwjotA/aIe5ir+nz/7tNdNyaTkAffypIyymOwlCi6zTcWpmY5G0Wmfy
Via88vVcZGFE1NBZFs5ZUvhlKkOvym739MvwRs6rpo+Jayu4dzyHgXZrR2nix/rp
3GIPE9O28bCdOHfR4HJ5WgcfllaC1IHYYe05P3PM51I15PDyGp/YmCaScaydp+fL
JyL7Z6RquaTGKDpNtksX3fZtR7p/bbFyUdHyo6VgotsfXxd7toCoKF4oat8tvJbo
Qke6a3+7hu66MGeo2CwXlC6IVe88HBWh+qskm6cD4X3aS8kpURklaKbAOR9ceDHx
6NmK/kpjVXAP/Plslb2J/gJM9m4qx72shawlpyLnH4x/DRn6ulxVYwLxTw+q251d
sWKBnym4z7hWq8eqYy5HD620YdsuUMEX/inyRtAVVTvi8MAk6G0=
=sgKe
-----END PGP SIGNATURE-----

--7ESul6TuRCN2yDNb--
